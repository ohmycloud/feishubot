use Cro::HTTP::Client;
use JSON::Fast;
use Digest::HMAC;
use Digest;
use Digest::SHA;
use MIME::Base64;

unit class FeiShuBot:ver<0.0.1>;

has Str $.hook-url is rw;
has Str $.secret is rw;
has Str $.timestamp is rw = now.Instant.Int.Str;
has %.headers is rw = content-type => 'application/json', user-agent => 'Cro';

method !gen-sign($timestamp, $secret) {
    my $string-to-sign = sprintf("%s\n%s", $timestamp, $secret);
    my $hmac-code = hmac($string-to-sign, "", &sha256);

    return MIME::Base64.encode($hmac-code);
}

method send($msg) {
    my $client = Cro::HTTP::Client.new(headers => |%.headers);
    my $sign = self!gen-sign($!timestamp, $!secret);
    my %content = msg_type => 'text', content => text => $msg, timestamp => $!timestamp, :$sign;

    my $resp = await $client.post: $!hook-url, body => to-json %content;
    await $resp.body-text;
}


=begin pod

=head1 NAME

FeiShuBot - A mini tool for sending message to feishu group.

=head1 SYNOPSIS

=begin code :lang<raku>

use FeiShuBot;

my $hook-url = "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
my $secret = "xxxxxxxxxxxxxxxxxxxxxx";
my $client = FeiShuBot.new(:$hook-url, :$secret);

my $msg = "I'm a bot";
$client.send($msg);

=end code

=head1 DESCRIPTION

FeiShuBot is a mini tool for sending message to feishu group.

=head1 AUTHOR

<ohmycloudy@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2022

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
