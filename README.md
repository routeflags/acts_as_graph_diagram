# Acts As Graph Diagram

Acts As Graph Diagram extends Active Record to add simple function for draw the Force Directed Graph with html.

![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
[![Gem Version](https://badge.fury.io/rb/acts_as_graph_diagram.svg)](https://badge.fury.io/rb/acts_as_graph_diagram)
![](https://ruby-gem-downloads-badge.herokuapp.com/acts_as_graph_diagram)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)
[![CircleCI](https://circleci.com/gh/smapira/acts_as_graph_diagram.svg?style=svg)](https://circleci.com/gh/smapira/acts_as_graph_diagram)

## See It Work

![acts_as_graph_diagram](https://user-images.githubusercontent.com/25024587/173231019-ede998c4-333a-48dd-b2da-96f04e1fce86.gif)

## Usage

Append the line to your model file like below:
```ruby
class God < ApplicationRecord
  acts_as_graph_diagram
end

God.find_by(name: 'Rheā').add_destination God.find_by(name: 'Hēra')
# => #<Edge:0x000000010b0d4560
#  id: 1,
#  comment: "",
#  cost: 0,
#  directed: true,
#  destination_type: "God",
#  destination_id: 2,
#  departure_type: "God",
#  departure_id: 1,
#  created_at: Sun, 12 Jun 2022 11:11:06.995007000 UTC +00:00,
#  updated_at: Sun, 12 Jun 2022 11:11:06.995007000 UTC +00:00>

God.find_by(name: 'Rheā').connecting_count
# => 1

God.find_by(name: 'Rheā').departures
# => [#<Edge:0x000000010b5642b0
#   id: 1,
#   comment: "",
#   cost: 0,
#   directed: true,
#   destination_type: "God",
#   destination_id: 2,
#   departure_type: "God",
#   departure_id: 1,
#   created_at: Sun, 12 Jun 2022 11:11:06.995007000 UTC +00:00,
#   updated_at: Sun, 12 Jun 2022 11:11:06.995007000 UTC +00:00>]

God.find_by(name: 'Rheā').departures.first.destination
# => #<God:0x000000010b5efb58 id: 2, name: "Hēra", created_at: Sun, 12 Jun 2022 11:11:06.984341000 UTC +00:00, updated_at: Sun, 12 Jun 2022 11:11:06.984341000 UTC +00:00>
```

### Methods

* destinations()
* departures()
* add_destination(node, comment: '', cost: 0)
* add_departure(node, comment: '', cost: 0)
* get_destination(node)
* get_departure(node)
* remove_destination(node)
* remove_departure(node)
* connecting?(node)
* connecting_count()
* add_connection(node, directed: false, comment: '', cost: 0)
* add_connection(node, directed: false, comment: '', cost: 0)
* sum_cost
* sum_tree_cost
* assemble_nodes

### Draws the graph diagram with D3.js

1. Append the lines to your controller file like below:
```ruby
class GodsController < ApplicationController
  def data_network
    render json: { 'nodes' => God.all.pluck(:id, :name)
                                 .map { |x| Hash[id: x[0], name: x[1]] },
                   'links' => Edge.all.pluck(:destination_id, :departure_id)
                                  .map { |x| Hash[target: x[0], source: x[1]] } }
  end
end
```

2. And append the line to your routes.rb file like below:
```ruby
Rails.application.routes.draw do
  get 'data_network' => 'gods#data_network'
end
```

3. Then append the line to your javascript file like below:
```javascript
// v7.4.4
d3.json("http://127.0.0.1:3000/data_network").then(function (graph) {});
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "acts_as_graph_diagram"
```

And then execute:
```bash
$ bundle
$ bin/rails generate acts_as_graph_diagram
$ bin/rails db:migrate
```

Or install it yourself as:
```bash
$ gem install acts_as_graph_diagram
```

## Development
### Test
```bash
bin/test
```

## Contributing
Bug reports and pull requests are welcome on Github at https://github.com/smapira/acts_as_graph_diagram. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the code of conduct.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Changelog
available [here](https://github.com/smapira/acts_as_graph_diagram/main/CHANGELOG.md).

## Code of Conduct
Everyone interacting in the ActsAsTreeDiagram project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/smapira/acts_as_graph_diagram/main/CODE_OF_CONDUCT.md).

## You may enjoy owning other libraries and my company.

* [acts_as_graph_diagram: ActsAsTreeDiagram extends ActsAsTree to add simple function for draw tree diagram with html.](https://github.com/smapira/acts_as_graph_diagram)
* [timeline_rails_helper: The TimelineRailsHelper provides a timeline_molecules_tag helper to draw a vertical time line usable with vanilla CSS.](https://github.com/smapira/timeline_rails_helper)
* [株式会社旗指物](https://blog.routeflags.com/)

## Аcknowledgments

- [activerecord - Model an undirected graph in Rails? - Stack Overflow](https://stackoverflow.com/questions/7976301/model-an-undirected-graph-in-rails)
- [tcocca/acts_as_follower: A Gem to add Follow functionality for models](https://github.com/tcocca/acts_as_follower)
- [Force layout | D3 in Depth](https://www.d3indepth.com/force-layout/)
- [Rubyを使って「なぜ関数プログラミングは重要か」を読み解く（改定）─ 前編 ─ 但し後編の予定なし](https://melborne.github.io/2013/01/21/why-fp-with-ruby/)