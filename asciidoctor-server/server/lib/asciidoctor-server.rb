# frozen_string_literal: true

require "thread"

require_relative "asciidoctor-server/version"
require_relative "asciidoctor-server/asciidoctor_services_pb"

module Asciidoctor
  module Server
    class AsciidoctorServer < Asciidoctor::Server::AsciidoctorConverter::Service
      @@chdir_mutex = Mutex.new

      def convert(convert_req, _unused_call)
        convert_req.extensions.each { |ext| require(ext) }
        doc = ''
        @@chdir_mutex.synchronize do
          Dir.chdir(convert_req.workdir) do
            doc = Asciidoctor.convert(
              convert_req.input,
              backend: convert_req.backend,
              attributes: convert_req.attributes.to_a,
              standalone: convert_req.standalone,
              safe: 'unsafe',
              base_dir: convert_req.basedir.empty? ? nil : convert_req.basedir
            )
          end
        end
        ::Asciidoctor::Server::AsciidoctorConvertReply.new(output: doc)
      end
    end
  end
end
