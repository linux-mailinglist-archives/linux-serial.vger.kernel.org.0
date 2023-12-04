Return-Path: <linux-serial+bounces-453-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD9780405E
	for <lists+linux-serial@lfdr.de>; Mon,  4 Dec 2023 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF11F212D6
	for <lists+linux-serial@lfdr.de>; Mon,  4 Dec 2023 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1823D2F849;
	Mon,  4 Dec 2023 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="FabWgz0B"
X-Original-To: linux-serial@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF47AA
	for <linux-serial@vger.kernel.org>; Mon,  4 Dec 2023 12:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=nUnKFbU+1IP5RwQf3eLQvf0DW03XbLlHMuIBUTFTbDc=; b=FabWgz0BSUdPD1kPPIAcxI9Ewx
	EeNXPHyXNBtT2DMKxMZHXjowyepj6e3x5D4tyIFrrh3gt17ghUfflKZWUWI2ePO6fWsoh1KBoxRRG
	1ummBejDlaVm+E9ZDddQ1miv3rOG7zKwvyr9TXp36tetFqPn6cXYMCI5FFcWQ/mjNP5o=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:45352 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rAFqw-0001TG-P9; Mon, 04 Dec 2023 15:47:43 -0500
Date: Mon, 4 Dec 2023 15:47:42 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Message-Id: <20231204154742.3aec6ab62378df433677102b@hugovil.com>
In-Reply-To: <20231204163804.1331415-3-andi.shyti@kernel.org>
References: <20231204163804.1331415-1-andi.shyti@kernel.org>
	<20231204163804.1331415-3-andi.shyti@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH 2/2] serial: ma35d1: Improve logging for out-of-bound
 console setup
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon,  4 Dec 2023 17:38:04 +0100
Andi Shyti <andi.shyti@kernel.org> wrote:

> An out-of-bound index results in an error and should not be
> logged merely as a debug message; it requires at least a warning
> level. Therefore, use pr_warn() instead of pr_debug.
> 
> Additionally, the log message itself has been improved for
> clarity.
> 
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Cc: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  drivers/tty/serial/ma35d1_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
> index 21b574f78b861..bcc402b4c0b2f 100644
> --- a/drivers/tty/serial/ma35d1_serial.c
> +++ b/drivers/tty/serial/ma35d1_serial.c
> @@ -599,7 +599,8 @@ static int __init ma35d1serial_console_setup(struct console *co, char *options)
>  	int flow = 'n';
>  
>  	if ((co->index < 0) || (co->index >= MA35_UART_NR)) {
> -		pr_debug("Console Port%x out of range\n", co->index);
> +		pr_warn("Failed to write on cononsole port %x, out of range\n",
> +			co->index);

Hi,
I do not see why this improves clarity...

You also introduced a syntax error "cononsole".

Hugo.


>  		return -EINVAL;
>  	}
>  
> -- 
> 2.43.0
> 
> 


-- 
Hugo Villeneuve

