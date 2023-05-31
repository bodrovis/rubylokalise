# frozen_string_literal: true

module Expectations
  using RubyLokaliseApi::Utils::Classes

  def expect_to_have_valid_resources(collection_obj)
    proper_collection(collection_obj, collection_from(collection_obj))

    proper_endpoint(collection_obj)
  end

  private

  def proper_collection(collection_obj, collection)
    expect(collection).to all(be_an_instance_of(resource_klass(collection_obj)))

    expect(endpoints(collection)).to all(be_an_instance_of(endpoint_klass_for(collection_obj)))

    expect(clients(collection)).to all(be_an_instance_of(RubyLokaliseApi::Client))
  end

  def proper_endpoint(collection_obj)
    res, ep = first_collection_endpoint(collection_from(collection_obj))

    params = res.class.const_get(:MAIN_PARAMS).to_array.map do |p|
      res.send(p).to_s
    end

    expect(ep.uri.split('/')).to include(*params)
  end

  def collection_from(obj)
    obj.collection
  end

  def first_collection_endpoint(collection)
    res = collection[0]
    ep = res.instance_variable_get(:@self_endpoint)

    [res, ep]
  end

  def resource_klass(collection_obj)
    collection_obj.class.const_get(:RESOURCE)
  end

  def clients(collection)
    collection.map do |c|
      c.instance_variable_get(:@self_endpoint).client
    end
  end

  def endpoints(collection)
    collection.map do |c|
      c.instance_variable_get(:@self_endpoint)
    end
  end

  def endpoint_klass_for(collection_obj)
    klass = collection_obj.class

    klass.const_defined?(:RESOURCES_ENDPOINT) ? klass.const_get(:RESOURCES_ENDPOINT) : klass.const_get(:ENDPOINT)
  end
end
