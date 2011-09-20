require 'code_insight/code_insight_helper'

module TeamIguana
  class CodeBase
    def initialize(project_dir)
      @project_dir = project_dir
    end

    def all_methods
      files=Dir.glob(File.join(@project_dir, '**', '*.rb'))
      files.map do |file|
        IO.read(file).scan(/def ([a-zA-Z_\?\!]+)/)
      end.flatten.select do |match|
        !match.nil?
      end.map do |m|
        m.to_sym
      end
    end
  end
end

codebase=TeamIguana::CodeBase.new(File.join(File.dirname(__FILE__), '..', '..', 'lib'))

describe "Object" do
  set_dynamic_methods :methods => codebase.all_methods
end