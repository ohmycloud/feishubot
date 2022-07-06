NAME
====

FeiShuBot - A mini tool for sending message to feishu group.

SYNOPSIS
========

```raku
use FeiShuBot;

use FeiShuBot;

my $hook-url = "https://open.feishu.cn/open-apis/bot/v2/hook/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
my $secret = "xxxxxxxxxxxxxxxxxxxxxx";
my $client = FeiShuBot.new(:$hook-url, :$secret);

my $msg = "I'm a bot";
$client.send($msg);
```

DESCRIPTION
===========

FeiShuBot is a mini tool for sending message to feishu group.

AUTHOR
======

<ohmycloud@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2022

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

