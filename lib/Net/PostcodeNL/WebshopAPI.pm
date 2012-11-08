package Net::PostcodeNL::WebshopAPI;

use strict;
use warnings;

use LWP::UserAgent;
use JSON::XS;
use URI::Template;

our $VERSION = '0.2';

my $AGENT = __PACKAGE__ . '/' . $VERSION;

sub new {
    my $class = shift;
    my %args = @_;

    my $self = {};

    $self->{user_agent} = $args{user_agent} ? $args{user_agent} : $AGENT;

    $self->{api_key} = $args{api_key};
    $self->{api_secret} = $args{api_secret};

    $self->{api_url} = URI::Template->new($args{api_url} || 'https://api.postcode.nl/rest/addresses{/zipcode,number,addition}');

    my $ua = LWP::UserAgent->new;
    $ua->agent($self->{user_agent});
    $self->{ua} = $ua;

    return bless $self, $class;
}

sub ua {
    my $self = shift;
    return $self->{ua};
}

sub lookup {
    my $self = shift;

    my ($zipcode, $number, $addition) = @_;

    my $uri = $self->api_url($zipcode, $number, $addition);

    my $ua = $self->ua;
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
    return $self->{api_url}->process({zipcode => $zipcode,number=> $number, addition => $addition });
}

1;