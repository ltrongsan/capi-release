# frozen_string_literal: true

require 'rspec'
require 'bosh/template/test'

module Bosh
  module Template
    module Test
      describe 'redis job template rendering' do
        let(:release_path) { File.join(File.dirname(__FILE__), '../..') }
        let(:release) { ReleaseDir.new(release_path) }
        let(:job) { release.job('redis') }
        let(:spec) { job.instance_variable_get(:@spec) }
        let(:job_path) { job.instance_variable_get(:@job_path) }
        let(:cc_internal_properties) { { 'cc' => { 'experimental' => { 'use_puma_webserver' => false, 'use_redis' => false } } } }
        let(:link) { Link.new(name: 'cloud_controller_internal', properties: cc_internal_properties) }

        describe 'monit' do
          let(:template) { Template.new(spec, File.join(job_path, 'monit')) }

          context 'when the puma webserver is used' do
            it 'renders the monit directives' do
              cc_internal_properties['cc']['experimental']['use_puma_webserver'] = true
              result = template.render({}, consumes: [link])
              expect(result).to include('check process redis')
            end
          end

          context "when 'cc.experimental.use_redis' is set to 'true'" do
            it 'renders the monit directives' do
              cc_internal_properties['cc']['experimental']['use_redis'] = true
              result = template.render({}, consumes: [link])
              expect(result).to include('check process redis')
            end
          end

          context "when neither the puma webserver is used nor 'cc.experimental.use_redis' is set to 'true'" do
            it 'does not render the monit directives' do
              result = template.render({}, consumes: [link])
              expect(result.strip).to eq('')
            end
          end
        end
      end
    end
  end
end
