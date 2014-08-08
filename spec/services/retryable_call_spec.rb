require 'spec_helper'

describe RetryableCall do

  it 'should return on non-blank response' do
    test_values = [true, 1, 0, '1', [''], {a: 1}]
    test_values.each do |val|
      RetryableCall.perform(sleep: 0) { val }.should eq val
    end
  end

  it 'should retry call on blank response' do
    itr = TestIterator.new([nil, nil, true])
    res = RetryableCall.perform(sleep: 0) { itr.call }
    res.should eq true
  end

  it 'should retry max number of times' do
    test_values = [nil, {}, [], '', ' ', nil, false, true, nil]
    itr = TestIterator.new(test_values)
    res = RetryableCall.perform(sleep: 0, max_retries: 1) { itr.call }
    res.should be_a Hash
    itr = TestIterator.new(test_values)
    res = RetryableCall.perform(sleep: 0, max_retries: 3) { itr.call }
    res.should be_a String
    itr = TestIterator.new(test_values)
    res = RetryableCall.perform(sleep: 0, max_retries: 7) { itr.call }
    res.should eq true
    itr = TestIterator.new(test_values)
    res = RetryableCall.perform(sleep: 0, max_retries: 100) { itr.call }
    res.should eq true
  end

end
