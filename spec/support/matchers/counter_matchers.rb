RSpec::Matchers.define :increment_counter_on do |object_with_counts|
  chain :for do |object_counted|
    @object_counted = object_counted
  end

  match do |block_to_test|
    prev_count = object_with_counts.send("#{@object_counted.to_s.underscore.downcase.pluralize}_count")
    block_to_test.call
    object_with_counts.reload
    object_with_counts.send("#{@object_counted.to_s.underscore.downcase.pluralize}_count") == prev_count+1
  end

  failure_message_for_should do
    "Creating a new '#{@object_counted}' should increment counters on '#{object_with_counts.class}'."
  end

  failure_message_for_should_not do
    "Creating a new '#{@object_counted}' should not increment counters on '#{object_with_counts.class}'."
  end
end

RSpec::Matchers.define :decrement_counter_on do |object_with_counts|
  chain :for do |object_counted|
    @object_counted = object_counted
  end

  match do |block_to_test|
    object_with_counts.reload
    prev_count = object_with_counts.send("#{@object_counted.to_s.underscore.downcase.pluralize}_count")
    block_to_test.call
    object_with_counts.reload
    object_with_counts.send("#{@object_counted.to_s.underscore.downcase.pluralize}_count") == prev_count-1
  end

  failure_message_for_should do
    "Destroying an instance of '#{@object_counted}' should increment counters on '#{object_with_counts.class}'."
  end

  failure_message_for_should_not do
    "Destroying an instance of '#{@object_counted}' should not increment counters on '#{object_with_counts.class}'."
  end
end
