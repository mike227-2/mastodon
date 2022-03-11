# frozen_string_literal: true
require 'openssl'
require 'uri'

module Epoch
  class ChargeRequest
    attr_accessor :action, :auth_amount, :close_amount, :member_id, :transaction_id,
                  :currency, :returnurl, :description, :x_description, :pb_url,
                  :x_parameters, :api, :epoch_digest

    def initialize()
      @api = 'camcharge'
    end

    def build_params
      to_hash
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end

    def build_digest
      sorted = build_params.sort_by { |key| key }.to_h
      stringified = ''
      sorted.each do |param|
        stringified = "#{stringified}#{param[0]}#{param[1]}"
      end
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('md5'), 'key', stringified)
    end

    def request
      @epoch_digest = build_digest

      to_hash
    end
  end
end
