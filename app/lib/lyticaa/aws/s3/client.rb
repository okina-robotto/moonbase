module Lyticaa
  module Aws
    module S3
      class Client
        def initialize(opts = {})
          @bucket = opts.fetch(:bucket)
          @prefix = opts.fetch(:prefix, nil)
        end

        attr_accessor :bucket, :prefix

        def list_files
          resource.bucket(bucket).objects(prefix:).collect(&:key)
        end

        def signed_url(key)
          resource.bucket(bucket).object(key).presigned_url(:get)
        end

        def copy_file(key, copy_source)
          client.copy_object(bucket:, copy_source:, key:)
        end

        def delete_file(key)
          client.delete_object bucket:, key:
        end

        def file(key)
          client.get_object bucket:, key:
        end

        private

        def resource
          @resource ||= ::Aws::S3::Resource.new client:
        end

        def client
          @client ||= ::Aws::S3::Client.new
        end
      end
    end
  end
end
