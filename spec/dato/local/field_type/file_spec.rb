# frozen_string_literal: true
require 'spec_helper'

module Dato
  module Local
    module FieldType
      RSpec.describe Dato::Local::FieldType::File do
        subject(:file) { described_class.parse(attributes, repo) }

        let(:repo) { instance_double('Dato::Local::ItemsRepo', site: site, entities_repo: entities_repo) }
        let(:site) { instance_double('Dato::Local::Site', entity: site_entity) }
        let(:site_entity) { double('Dato::Local::JsonApiEntity', imgix_host: 'foobar.com') }
        let(:entities_repo) { instance_double('Dato::Local::EntitiesRepo', find_entity: upload_entity) }
        let(:upload_entity) { double('Dato::Local::JsonApiEntity', attributes ) }

        let(:attributes) do
          {
            path: '/foo.png',
            format: 'jpg',
            size: 4000,
            width: 20,
            height: 20,
            alt: "an alt",
            title: "a title"
          }
        end

        it 'responds to path, format and size methods' do
          expect(file.path).to eq '/foo.png'
          expect(file.format).to eq 'jpg'
          expect(file.size).to eq 4000
          expect(file.width).to eq 20
          expect(file.height).to eq 20
        end

        it 'responds to url method' do
          expect(file.url(w: 300)).to eq 'https://foobar.com/foo.png?w=300'
        end
      end
    end
  end
end
