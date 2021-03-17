Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

Your task

Your task will deal with one aspect of listing processing, namely, addresses and their parsing.

As we process real estate listings, all types of addresses show up: incomplete, malformed, not formatted properly, with multiple typos, etc.

We must take steps to normalise and parse the address strings by splitting them into components such as house number, street, city, etc. which we can then store and combine the way we need to.

What you have to do is to build a service that is:

accessible with HTTP/HTTPS
has a single endpoint that accepts an address string and returns address components
E.g. given the input of

address=Julie-Wolfthorn-Straße 1, Berlin
the return value could look like

{

  :street_number => "1",
  :street => "Julie-Wolfthorn-Str.",
  :district => "Mitte",
  :city => "Berlin",
  :state => "Berlin",
  :country=>"Germany"

}
We also expect the service to return an error response in case it cannot process an address.

Input data

the attached file contains various addresses, you can use them to test your implementation.

Requirements

The service should be written in Ruby. The rest - framework, choice of libraries/gems/external services - is entirely up to you.

What we expect as a result

a PR to this repo with your code
tests, obviously
a reason behind the choices you've made
Some hints

Geocoding, though meant to provide coordinates for address, can also be used to parse addresses. You can check google's geocoding API or any other geocoding APIs.
Instant response is not required, but the service is going to receive a lot of calls.
The service should be deployable without too much effort.
