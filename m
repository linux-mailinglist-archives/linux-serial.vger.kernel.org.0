Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5BCC50DC9
	for <lists+linux-serial@lfdr.de>; Mon, 24 Jun 2019 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfFXOXW (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 24 Jun 2019 10:23:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39776 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfFXOXW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 24 Jun 2019 10:23:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id v18so12794230ljh.6;
        Mon, 24 Jun 2019 07:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGHNzjTTkC7XSqkNKO0Dj0BBPmg9DOd1ASPbbQfSUIQ=;
        b=a6mvrtETWDQIoQzNQzaG0r1m0wNREjXOUvKP8YgKSrXgH7IWnax57HEEUp6QnAX2Zw
         0v28Crv6RfnaMnDg3wxi73ufOqCIu3IsGjifIiZ6WFyTOTN2pre4L6vIP30YyY4G2oJ/
         Knt2HknmHYH+JfkbptJh4I51oNNWGxm9tKtWc0G9iGJx06qsjjWBf0Ty1vRkfiiT58/c
         fTgToj6iRFdpPhKMVF3S59jMdRDBIvi8jDZlPQxXXEP1XDkjBt767vrDE3ftcEiT+5+O
         t74HZargsBE4m49XNOB6CRoM75Pk3gOld8T4J2m+6fYXHV7NOMQs5pH9aFwIQJOzL6ie
         RriQ==
X-Gm-Message-State: APjAAAWzCuH7w4SBR5mGs7VPwYJnvLU0OnScdHnHXDoLQjODp3+Pr78p
        5ObT8GUSsbSSkBMVXI1kJxg=
X-Google-Smtp-Source: APXvYqxQFnqLSlWHbgblNv8zbvjH5AV2mWcwcU0h0Y8jlXvW2YH/P7kGeDL2xDiHxr1mKCDpUpmNMw==
X-Received: by 2002:a2e:8793:: with SMTP id n19mr1094836lji.174.1561386199989;
        Mon, 24 Jun 2019 07:23:19 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m17sm1784222lfb.9.2019.06.24.07.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:23:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92)
        (envelope-from <johan@kernel.org>)
        id 1hfPsN-0003Iw-QI; Mon, 24 Jun 2019 16:23:19 +0200
Date:   Mon, 24 Jun 2019 16:23:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Shyam Saini <mayhs11saini@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-usb@vger.kernel.org
Subject: Re: junk character issue on minicom and screen
Message-ID: <20190624142319.GB14667@localhost>
References: <CAOfkYf4kCTWdjDJSG0=KgZZG7F+HpE+m+RbgLZ=NeczZ5uWPRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOfkYf4kCTWdjDJSG0=KgZZG7F+HpE+m+RbgLZ=NeczZ5uWPRw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 24, 2019 at 02:57:34PM +0530, Shyam Saini wrote:
> Hello everyone,
> 
> I'm working on Rockchip rk3399 Nanopc t4 board and I'm trying get
> serial output from board using minicom and my board has baudrate
> 1500000.
> 
> I'm using a usb to serial converter. So, when i power on my board
> minicom starts to give junk characters.
> Minicom version:  2.7.1
> USB driver probed : cp210x
> 
> But when I use the same setup with my colleagues laptop it gives
> correct output (kernel version 4.15.0-52-generic ).
> 
> Note that my colleague and i used same setup
> Same usb driver probed
> Same power adapter
> same usb to serial converter wire
> same minicom version.
> same baudrate
> 
> Other thing which i tried is switching kernel version and it turns out
> that one of the older distro kernel on my system (debian 4.9.0-5-amd64
> ) is working fine and it seems like there is something changed in
> newer kernel vesions.
> Here is the quick summary
> 4.19.0-4-amd64    -> not working
> 4.15.0-52-generic -> working
> 4.9.0-5-amd64      -> working
> 5.2.0-rc4+             -> not working

Thanks for the report. There were some changes between 4.15 and 4.19
related to the line speed handling which may have broken something in
your setup.

Do you know which variant of cp210x you have? Can your provide the
output of lsusb -v?

Also if you can run driver with debugging enabled when connecting the
device and setting the line speed, that may give a clue about what is
going on. For example,

	echo module cp210x =p > /sys/kernel/debug/dynamic_debug/control

Does 115200 bps still work by the way?

Johan
