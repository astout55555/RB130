class Device
  def initialize
    @recordings = []
  end

  def listen(&block)
    record(block) if block_given?
  end

  def play
    puts @recordings.last.call
  end

  private

  def record(recording)
    @recordings << recording
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

## LS Solution:

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    return unless block_given?
    recording = yield # init local var to return of yield, instead of explicit block param
    record(recording) # then pass var to #record
  end

  def play
    puts @recordings.last # no #call required this way. maybe better than collecting blocks
  end
end
