require 'tire'
require 'benchmark'

namespace :search do

  task :import => :environment do
    time = Time.new.utc
    classes_to_index = [ Event, Talk, Idea, Action ]
    puts "[Import all]\tWill import classes: #{classes_to_index.map(&:name).join(", ")}..."
    importers = classes_to_index.map { | klass | ClassImporter.new(klass, time: time) }

    importers.map(&:do_import)
    puts
    importers.map(&:switch_aliases)
    puts 

    puts "[Import all]\tSetting up 'all' alias..."
    old_indexes = []
    ClassImporter.switch_aliases("#{Rails.env}-all", old_indexes, *importers.map(&:index_name))

    delete_old_indexes = ENV['DELETE_OLD_INDEXES'] || (Rails.env.test? or Rails.env.development?)
    if delete_old_indexes
      old_indexes.push(*importers.map(&:old_indexes).flatten).uniq.each do | old_index |
        puts "[Import all]\tWill delete old index '#{old_index}'..."
        Tire::Index.new(old_index).delete
      end
    end
  end

  class ClassImporter
    def initialize(klass, override_params = {})
      params = { method: 'paginate' }.merge(override_params)
      @klass = klass
      @time = params.delete(:time)
      @index_name = params.delete(:index_name)
      @alias_name = params.delete(:alias_name)
      @params = params
    end

    attr_accessor :klass, :params, :delete_old_index

    def index_base_name 
      @index_base_name ||= klass.tire.index.name
    end

    def alias_name
      @alias_name ||= klass.tire.index.name
    end

    def time
      @time ||= Time.new.utc
    end

    def index_name
      @index_name ||= "#{index_base_name}-#{time.strftime('%Y-%m-%d-%H%M%S')}"
    end

    def prefix
      "[Import '#{klass.name}']"
    end

    def do_import
      index = Tire::Index.new( index_name )

      puts
      unless index.exists?
        mapping = MultiJson.encode(klass.tire.mapping_to_hash, :pretty => Tire::Configuration.pretty)
        puts "#{prefix}\tCreating index '#{index.name}' with mapping:\n\t#{mapping}"
        unless index.create( :mappings => klass.tire.mapping_to_hash, :settings => klass.tire.settings )
          STDERR.puts "#{prefix}\tERROR: There has been an error when creating the index -- Elasticsearch returned:",
                      index.response
          exit(1)
        end
      end

      STDOUT.sync = true
      puts "#{prefix}\tStarting import for '#{klass.name}' class"
      tty_cols = 80
      total    = klass.count rescue nil
      offset   = (total.to_s.size*2)+8
      done     = 0

      STDOUT.puts 
      elapsed = Benchmark.realtime do

        # Add Kaminari-powered "paginate" method
        #
        if defined?(Kaminari) && klass.respond_to?(:page)
          klass.instance_eval do
            def paginate(options = {})
              page(options[:page]).per(options[:per_page]).to_a
            end
          end
        end unless klass.respond_to?(:paginate)

        # Import the documents
        #
        index.import(klass, params) do | documents |

          if total
            done += documents.to_a.size
            # I CAN HAZ PROGREZ BAR LIEK HOMEBRU!
            percent  = ( (done.to_f / total) * 100 ).to_i
            glyphs   = ( percent * ( (tty_cols-offset).to_f/100 ) ).to_i
            STDOUT.print( "#" * glyphs )
            STDOUT.print( "\r"*tty_cols+"#{prefix} #{done}/#{total} | \e[1m#{percent}%\e[0m " )
          end

          # Don't forget to return the documents collection back!
          documents
        end
      end

      puts "", "#{prefix}\tImport for class '#{klass.name}' finished in #{elapsed_to_human(elapsed)}"
    end

    def switch_aliases
      STDOUT.sync = true
      puts "#{prefix}\tSetting up aliases for class '#{klass.name}'..."
      self.class.switch_aliases(alias_name, old_indexes, index_name)
    end

    def self.switch_aliases(alias_name, old_indexes, *new_index_names)
      _alias = Tire::Alias.find(alias_name, &aliases_proc(alias_name, old_indexes, *new_index_names))
      unless _alias
        _alias = Tire::Alias.new(name: alias_name, &aliases_proc(alias_name, old_indexes, *new_index_names))
      end
      _alias.save
    end

    def old_indexes
      @old_indexes ||= []
    end

    def self.aliases_proc(alias_name, old_indexes, *new_index_names)
      Proc.new { | _alias |
        if _alias 
          _alias.indices.delete_if do | old_index_name | 
            old_indexes << old_index_name
            puts "\t'#{alias_name}' -/-> '#{old_index_name}'..."
            true
          end 

          new_index_names.each do | new_index_name |
            puts "\t'#{alias_name}' ---> '#{new_index_name}'..."
            _alias.index new_index_name
          end
        end
      }
    end

    private

    def elapsed_to_human(elapsed)
      hour = 60*60
      day  = hour*24

      case elapsed
      when 0..59
        "#{sprintf("%1.2f", elapsed)} seconds"
      when 60..hour-1
        "#{(elapsed/60).floor} minutes and #{(elapsed % 60).floor} seconds"
      when hour..day
        "#{(elapsed/hour).floor} hours and #{(elapsed/60 % hour).floor} minutes"
      else
        "#{(elapsed/hour).round} hours"
      end
    end

  end

end