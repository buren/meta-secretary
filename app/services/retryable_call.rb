class RetryableCall
  DEFAULT_OPTIONS = {
    sleep:       0.5,
    max_retries: 5
  }

  def self.perform options = {}, &block
    new(options).perform(&block)
  end

  def initialize options = {}
    @options = DEFAULT_OPTIONS.merge(options)
  end

  # Retries given block until not blank or max_retries is reached
  # returns the first non-blank object
  def perform &block
    response = nil
    tries    = 0
    while response.blank?
      break if tries > @options[:max_retries]
      response = block.call
      tries += 1
      sleep @options[:sleep]
    end
    response
  end

end
