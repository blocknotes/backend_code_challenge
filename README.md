# Backend Code Challenge

## Usage

- Install dependencies: `bundle install`
- Run (a file _data/feed.xml_ is required): `bundle exec ruby app.rb`
- Or specifing an input file: `bundle exec ruby app.rb data/feed2.xml`

Sample output:

```
Received batch   1
Size:       5.00MB
Products:    14734

Received batch   2
Size:       5.00MB
Products:    14899

Received batch   3
Size:       5.00MB
Products:    17386

Received batch   4
Size:       1.20MB
Products:     3052
```

## Notes

- The commits follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) convention (useful for example with [Release Please GitHub Action](https://github.com/googleapis/release-please-action))
- Each component of the flow is kept in a single file to make them more maintainable and testable
- As XML parser I'm using _ox_ gem which is pretty fast
- _data/feed.xml_ is only a small sample, I added it to have a working sample and to leave out the original feed (which is a quite big file)
- _app.rb_ accepts a single optional argument: the path to the XML file, useful to run the processing using the original sample
- RuboCop linter is pre-configured using [Relaxed Style](https://relaxed.ruby.style/)
- Batch size is rebalanced automatically to meet the requirement of 5 Mb max batch size og the external service

## Future improvements

- A nice have for a process that parse input files and interact with an external service could be to have the ability to be interrupted and restated easily, for example implementing a state of the processing flow
- Keeping a track of each processed entity could also increase the observability of this flow and it could allow to store error messages related to a specific item processing result
- I can't guess anything about the external service, but since it's external we could expect some outages, errors or poor performances in some situations, so it would be nice to handle retrials, and if we are going to use a background job for this kind of task it could be nice to use an exponential backoff
- For the components it would be nice to introduce a standard, for example using the [sunny/actor](https://github.com/sunny/actor) gem or simply following an internal convention
- The tests could be expanded to cover more edge cases, for example if the 5 Mb size limit is quite important it could be useful to add some tests when the data reach that limit or to check the error handling case when a batch fails to be processed
- In case of huge files, it could be useful to update the components to use Ox stream parsing and updating the processing component accordingly
