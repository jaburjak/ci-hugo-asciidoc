# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: asciidoctor.proto

require 'google/protobuf'


descriptor_data = "\n\x11\x61sciidoctor.proto\x12\x0b\x61sciidoctor\"\x99\x01\n\x19\x41sciidoctorConvertRequest\x12\x0f\n\x07\x62\x61sedir\x18\x07 \x01(\t\x12\x0f\n\x07workdir\x18\x06 \x01(\t\x12\x12\n\nstandalone\x18\x05 \x01(\x08\x12\x12\n\nextensions\x18\x03 \x03(\t\x12\x0f\n\x07\x62\x61\x63kend\x18\x04 \x01(\t\x12\x12\n\nattributes\x18\x02 \x03(\t\x12\r\n\x05input\x18\x01 \x01(\t\")\n\x17\x41sciidoctorConvertReply\x12\x0e\n\x06output\x18\x01 \x01(\t2q\n\x14\x41sciidoctorConverter\x12Y\n\x07\x43onvert\x12&.asciidoctor.AsciidoctorConvertRequest\x1a$.asciidoctor.AsciidoctorConvertReply\"\x00\x42KZ3com.github/hybras/asciidoctor-server/client-go/grpc\xea\x02\x13\x41sciidoctor::Serverb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool
pool.add_serialized_file(descriptor_data)

module Asciidoctor
  module Server
    AsciidoctorConvertRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("asciidoctor.AsciidoctorConvertRequest").msgclass
    AsciidoctorConvertReply = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("asciidoctor.AsciidoctorConvertReply").msgclass
  end
end
