package Net::PostcodeNL::WebshopAPI;

use strict;
use warnings;

use LWP::UserAgent;
use JSON::XS;

use URI;
use URI::QueryParam;
use URI::Template;

sub new {
    my $class = shift;
    my %args = @_;
    my $self = {};

    $self->{api_key} = $args{api_key};
    $self->{api_secret} = $args{api_secret};

    $self->{api_url} = URI::Template->new($args{api_url} || 'https://api.postcode.nl/rest/addresses{/zipcode,number,addition}');

    return bless $self, $class;
}


sub lookup {
    my $self = shift;
    my ($zipcode, $number, $addition) = @_;

    my $uri = $self->api_url($zipcode, $number, $addition);

    my $ua = LWP::UserAgent->new();
    $ua->credentials($uri->host_port, 'REST Endpoint', $self->{api_key}, $self->{api_secret}); 
    my $resp = $ua->get($uri);

    if ($resp->code == 200 && $resp->header('Content-Type') eq 'application/json') {
        return decode_json($resp->decoded_content);
    }
    return decode_json($resp->decoded_content);
}

sub api_url {
    my $self = shift;
    my ($zipcode, $number, $addition) = @_;
    my $uri = $self->{api_url}->process({zipcode => $zipcode,number=> $number, addition => $addition });

    print $uri . "\n";
    return $uri;
}

1;
