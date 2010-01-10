HAPI
====

HAPI provides a generic abstraction layer for dealing with simple HTTP APIs 
that return XML content.

Installing
----------

    gem install hapi

Using
-----

Making an API call is a simple matter.
1. Create the HAPI::APICall object
2. Set the parameters you want to send
3. Fire the post() or get() methods

    require 'hapi'
    h = HAPI::APICall.new "https://path.to/my/api"
    h.params = {'user' => 'rodjek, 'foo' => 'bar'}
    response = h.post

The XML content result is parsed by [xml-object][0] and returned at a Ruby 
object for simplicity.

i.e.

    <response>
        <result>
            <command>foo</command>
            <code>0</code>
        </result>
    </response>

Can be accessed as follows

    response.result.command
    => "foo"
    response.result.code
    => "0"

Copyright
---------
Copyright (c) 2010 Tim Sharpe. See LICENSE for details.

[0]: http://github.com/jordi/xml-object
