Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18947180079
	for <lists+linux-serial@lfdr.de>; Tue, 10 Mar 2020 15:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCJOnd (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 10 Mar 2020 10:43:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46561 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgCJOnd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 10:43:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so16176844wrw.13
        for <linux-serial@vger.kernel.org>; Tue, 10 Mar 2020 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2UmDmkSQrIpR1TGpQSx2rPLZzPTtLc8SuWXws859bHQ=;
        b=RlFkidqDCB6m6ZeGWsYkQMpB7WNsn2bMohkfQRwD/D4gLQJD0SCH4BuvgUPG6DFWB6
         96xrFGRTa5uGmUXZbBrXDIDsZWk388jgt24Dcwa2ngRJe1Qy+yIG6WZPU0Tor1OUbl5o
         vPXcqXMFVkuODTauWO18qx+wtda3nlZ8AxwkpqVnlUtXvyl3VNqwYKSNvTLhPCd/Vmoi
         m+VICUGUpe0g7AJwW3oy8yT0AxSL7bdZTIACn7PBu1Rd0swkToVnN/hxe6czUQIPcKBY
         1uA/XPkrhXWt6M2IGQguWqZ9CFp2YaJ3Hf/J3VJz27JLABA918tuzhhy/cpUONIzN0PZ
         inwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2UmDmkSQrIpR1TGpQSx2rPLZzPTtLc8SuWXws859bHQ=;
        b=GAy4lMa72jWAwycrcbvmyw+HL6Rd+OtZyGcazz47n+Tw2tbzBoX46pcsrLdIJVf8KF
         rdQWzdfWzL/xZ2KewzEorgA+AvfCjGM1KB1w/OLXriD/I3CA+deUZCvYYsebzmFofOIY
         5GD0c6ZN8V1qz7/tto6ZVRaXJZ558eLDOf/6xiGW4sEJ65cVZjGu4uAcHaJKBkmA4uB5
         90FQ3YMk8ES1pKJxiBPSIJc5qnnCV9TX6LCcNz2epbOUPaxPFTluucIJjoXNQYqBTG7T
         RD5QQAANWj8F+rXWs2Jy1Aw5yUIkg1mZ4U/E45Loo29ZUpMG0yW9Hu9ZxZc/uuwx5cix
         2Ecw==
X-Gm-Message-State: ANhLgQ20/MCsfflOght0M6L7QutTWBS2vt+L6jkipIu/Ibnvd2nEi4vE
        iyl1Hrl+j+hubm0Qf4dodTxto0Lp
X-Google-Smtp-Source: ADFU+vuYS4X/jXtd4Xep9DNpRT7r8aNZHqfZ3WRprCchQhj4xByhOjZ+ObObEYDgACKr6lLCxgLVtQ==
X-Received: by 2002:adf:f309:: with SMTP id i9mr18954485wro.0.1583851411734;
        Tue, 10 Mar 2020 07:43:31 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t187sm4506665wmt.25.2020.03.10.07.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 07:43:31 -0700 (PDT)
Subject: Re: [PATCH v1 3/4] serial: core: Use uart_console() helper in SysRq
 code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
 <20200310132004.86367-3-andriy.shevchenko@linux.intel.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <aaa64ae1-1cbe-f3ff-e9fc-d66cc3c29b5b@gmail.com>
Date:   Tue, 10 Mar 2020 14:43:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200310132004.86367-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/10/20 1:20 PM, Andy Shevchenko wrote:
> Use uart_console() helper in SysRq code instead of open coded variant.
> This eliminates the conditional entirely for SERIAL_CORE_CONSOLE=n case.
> While here, refactor the conditional to be more compact.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks,
Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

> ---
>  drivers/tty/serial/serial_core.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index e3f2afc15ad4..e3f8e641e3a7 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -3315,14 +3315,12 @@ int uart_handle_break(struct uart_port *port)
>  	if (port->handle_break)
>  		port->handle_break(port);
>  
> -	if (port->has_sysrq) {
> -		if (port->cons && port->cons->index == port->line) {
> -			if (!port->sysrq) {
> -				port->sysrq = jiffies + SYSRQ_TIMEOUT;
> -				return 1;
> -			}
> -			port->sysrq = 0;
> +	if (port->has_sysrq && uart_console(port)) {
> +		if (!port->sysrq) {
> +			port->sysrq = jiffies + SYSRQ_TIMEOUT;
> +			return 1;
>  		}
> +		port->sysrq = 0;
>  	}
>  
>  	if (port->flags & UPF_SAK)
> 

Thanks,
          Dmitry
