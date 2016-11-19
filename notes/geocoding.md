There are a few options to handle addresses:
We probably want to save both the address (string) and the coordinates (PostGIS / GeoJSON)

How does entering data work?
The user should only enter the address and then either:

(1) Client-side Javascript calls an external geocoding API, gets the response, and sends it as the "coordinates" field of the POST request to /places/. The server decodes and enters it to :coordinates.

(2) The client-side submits just the address. A service is invoked on the server-side, which calls an external geocoding API, decoding and adding the result to :coordinates.

I don't see a big issue with the client-side implementation.
Yes, we trust the user to input the location correctly, but we do that anyway.
The only issue is a dissonance between the address and the coordinates, in case the user sends a fake coordinates field in the request.
Mind that only admin users can submit new places, so griefing is not common.

Using server-side geocoding is a bit harder at the moment, due to a lack of good elixir libraries.
There is https://github.com/knrz/geocoder, but it seems to target a continuous need for geocoding, e.g. users searching live based on address.
If we decide to pursue these features (probably not; I'd rather it be category- and coordinate- focused), then a full server-side implementation might be worth it.


For the forseeable future, geocoding is only used in adding the places.
Every distance comparison is then handled with coordinates.
