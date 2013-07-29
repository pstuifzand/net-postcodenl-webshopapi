# NAME

Net::PostcodeNL::WebshopAPI - Postcode.nl Webshop API

# SYNOPSYS

    use Net::PostcodeNL::WebshopAPI;

    my $api = Net::PostcodeNL::WebshopAPI->new(
        api_key    => 'insert api key',
        api_secret => 'insert api secret',
    );

    my $zipcode = '';
    my $number = '';
    my $addition = '';

    my $r = $api->lookup($zipcode, $number, $addition);

    if ($r->is_error) {
        die $r->err_str;
    }
    else {
        say $r->street;
        say $r->houseNumber;
        say $r->houseNumberAddition;
    }

# DESCRIPTION

Retrieves information about a zipcode from Postcode.nl

You need to apply for a key and secret from [http://api.postcode.nl](http://api.postcode.nl).

# METHODS

## $r = $self->lookup($zipcode, $number, $addition);

Returns a [Net::PostcodeNL::WebshopAPI::Response](http://search.cpan.org/perldoc?Net::PostcodeNL::WebshopAPI::Response) for the combination of
`$zipcode`, `$number` and `$addition`.

# SEE ALSO

[Net::PostcodeNL::WebshopAPI::Response](http://search.cpan.org/perldoc?Net::PostcodeNL::WebshopAPI::Response)

# AUTHOR

Peter Stuifzand <peter@stuifzand.eu>

# LICENSE

Same as Perl.
