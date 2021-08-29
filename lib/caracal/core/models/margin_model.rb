require 'caracal/core/models/base_model'


module Caracal
  module Core
    module Models
      
      # This class handles block options passed to the margins
      # method.
      #
      class MarginModel < BaseModel
        
        #-------------------------------------------------------------
        # Configuration
        #-------------------------------------------------------------
        
        # constants
        const_set(:DEFAULT_MARGIN_TOP,    0)  # units in twips
        const_set(:DEFAULT_MARGIN_BOTTOM, 0)  # units in twips
        const_set(:DEFAULT_MARGIN_LEFT,   0)  # units in twips
        const_set(:DEFAULT_MARGIN_RIGHT,  0)  # units in twips
        const_set(:DEFAULT_MARGIN_HEADER,  709)  # units in twips
        const_set(:DEFAULT_MARGIN_FOOTER,  709)  # units in twips

        # accessors
        attr_reader :margin_top
        attr_reader :margin_bottom
        attr_reader :margin_left
        attr_reader :margin_right
        attr_reader :margin_header
        attr_reader :margin_footer

        
        # initialization
        def initialize(options={}, &block)
          @margin_top    = DEFAULT_MARGIN_TOP
          @margin_bottom = DEFAULT_MARGIN_BOTTOM
          @margin_left   = DEFAULT_MARGIN_LEFT
          @margin_right  = DEFAULT_MARGIN_RIGHT
          @margin_header  = DEFAULT_MARGIN_HEADER
          @margin_footer  = DEFAULT_MARGIN_FOOTER

          super options, &block
        end
        
        
        #-------------------------------------------------------------
        # Public Methods
        #-------------------------------------------------------------
        
        #=============== SETTERS ==============================
        
        # integers
        [:bottom, :left, :right, :top, :header, :footer].each do |m|
          define_method "#{ m }" do |value|
            instance_variable_set("@margin_#{ m }", value.to_i)
          end
        end
        
        
        #=============== VALIDATION ==============================
        
        def valid?
          dims = [:bottom, :left, :right, :top]
          dims.map { |d| send("margin_#{ d }") }.all? { |d| d > 0 }
        end
        
        
        #-------------------------------------------------------------
        # Private Instance Methods
        #-------------------------------------------------------------
        private
        
        def option_keys
          [:top, :bottom, :left, :right, :header, :footer]
        end
        
      end
      
    end
  end
end