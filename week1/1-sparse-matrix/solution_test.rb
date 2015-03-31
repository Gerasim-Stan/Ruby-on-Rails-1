require 'rspec'

require_relative 'solution'

describe "does sparse matrix algo works" do
  it "tests with primary example" do
    sparse_matrix = [[1, nil, nil, nil],
                     [nil, 2, 5, nil],
                     [6, nil, nil, 7],
                     [nil, 3, nil, 4]]
    output = [[0, 1], [1, 2], [2, 5], [0, 6], nil, [1, 3], [3, 7], [3, 4]]
    expect(tarjan(sparse_matrix)).to eq output
  end
end
