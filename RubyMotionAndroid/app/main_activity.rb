class ShowMapButtonListener
  attr_accessor :addrText

  def onClick(view)
    begin

      @geoIntent = Android::Content::Intent.new(
        Android::Content::Intent::ACTION_VIEW,
        Android::Net::Uri.parse("geo:0,0?q=#{addrText.text}"))

      view.getContext().startActivity(@geoIntent)

    rescue => error
      puts "ERROR: #{error.message}"
    end
  end
end


class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super

    setContentView(resources.getIdentifier('main', 'layout', packageName))
    addrText = findViewById(resources.getIdentifier('location', 'id', packageName))
    button   = findViewById(resources.getIdentifier('mapButton', 'id', packageName))

    @listener = ShowMapButtonListener.new
    @listener.addrText = addrText
    button.onClickListener = @listener
  end
end
