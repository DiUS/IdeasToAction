require 'spec_helper'

describe SearchController do

  describe "GET 'index'" do
    let(:params) { {} }
    let(:search_query) { double("search query", valid?: true, text: 'body language') }

    before :each do
      SearchQuery.stub(:new).with(params).and_return(search_query)
    end

    it "should create a search query model from the params" do
      SearchQuery.should_receive(:new).with(params).and_return(search_query)
      get 'index', params
    end

    context "when query is invalid" do
      before :each do
        search_query.should_receive(:valid?).and_return(false)
      end

      it "should return an error response" do
        search_query.should_receive(:errors).and_return([])
        get 'index'
        response.should_not be_success
      end
    end

    context "when query is provided" do      
      let(:params){{'text' => 'body language'}}

      context "when format is not JSON" do
        it "should return a failed response" do
          get 'index', params.merge(format: :html)
          response.should_not be_success
        end
      end

      context "when format is JSON" do
        let(:search_obj){double('tire search obj', results: results)}
        let(:results){[{}, {}, {}]}

        it "should use ES to search for records" do
          controller.should_receive(:create_search).with(search_query).and_return(search_obj)
          get 'index', params.merge(format: :json)
          response.should be_success
        end
      end
    end

  end

end
