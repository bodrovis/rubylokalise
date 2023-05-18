# frozen_string_literal: true

module Expectations
  def expect_to_have_valid_resources(collection_obj)
    collection = collection_obj.collection

    resource_klass = collection_obj.class.const_get(:RESOURCE)

    expect(collection).to all(be_an_instance_of(resource_klass))
    expect(collection.map do |c|
             c.instance_variable_get(:@self_endpoint)
           end).to all(be_an_instance_of(endpoint_klass_for(collection_obj)))
  end

  private

  def endpoint_klass_for(collection_obj)
    klass = collection_obj.class

    klass.const_defined?(:RESOURCES_ENDPOINT) ? klass.const_get(:RESOURCES_ENDPOINT) : klass.const_get(:ENDPOINT)
  end
end
