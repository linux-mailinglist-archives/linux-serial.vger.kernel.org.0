Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E5D1796F9
	for <lists+linux-serial@lfdr.de>; Wed,  4 Mar 2020 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgCDRsL (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 4 Mar 2020 12:48:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbgCDRsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Mar 2020 12:48:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id 7so1333783pgr.2
        for <linux-serial@vger.kernel.org>; Wed, 04 Mar 2020 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=twGLnt+lmzXmDy1fmr6l/q0nR+L298UBQxbGpY/MAj8=;
        b=k6YAwfak0/W2GVfXJfFjcN+yUxxw9CfC/ZDF0pN8DxQ9RY/NFfw1tlOwloaFkEzku0
         zYUPFBB8Jm4t9mUk1WcmmHonxbFKFRtqYc1UrWhZIGWBmjpGp8o60J5KAla6g4lFNxIG
         yt9AAuoCDNXz+t9V+oMMAt3ytn93GlzKJgKZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=twGLnt+lmzXmDy1fmr6l/q0nR+L298UBQxbGpY/MAj8=;
        b=DJrOJ39I+iwmmEdGEZP/cRCuu+OfMaBG+wPMKtOyQLctEvcWNKYq3nCvSlydWq7ijd
         pZkpHAaOYcJB3EJGKFZ5oiB8g4J5de76OZP+bpU93sOKaQsn9Y3DB8Tgh7Dkl3iUqV+t
         d+zzuB6mCFoHtv1K0P7mZdML9z726quNm7LbGFUkIpb0e/OqZHYMvOMp0TBqJkN/miyW
         JthBhacENPMvJXp5sqZjfjbN8vEyN++h2xUSnFzabfO3yqo2GMmQjmXo+zjwkR+SzTSm
         nET+E/ruFs8dxvc/oo1wwRK68CwClVe1RJKEhS4nXuNiwydgufdFPvHvwefyI9GDS8f2
         eo3g==
X-Gm-Message-State: ANhLgQ0kJglyEGGjiZf++CVjMnlyvoE3eyAgWnD8W+sInqkH7hk86ufH
        WCH9aSvDDWCd+e011j7Ons+rCA==
X-Google-Smtp-Source: ADFU+vubQzHiwMT605UwbFGoQU9KrBzbPaI/Yk1SN96yMJN8ZKf97NgPO6eQPQtzCbnOP6XNMi0biw==
X-Received: by 2002:a63:c546:: with SMTP id g6mr3442441pgd.243.1583344090047;
        Wed, 04 Mar 2020 09:48:10 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y1sm25767982pgs.74.2020.03.04.09.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:48:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f7cfe1e4101af5133cc8b70753d20beb@codeaurora.org>
References: <1582638862-9344-1-git-send-email-skakit@codeaurora.org> <1582638862-9344-2-git-send-email-skakit@codeaurora.org> <158293088963.112031.11417422453396901116@swboyd.mtv.corp.google.com> <f7cfe1e4101af5133cc8b70753d20beb@codeaurora.org>
Subject: Re: [PATCH V2 1/2] tty: serial: qcom_geni_serial: Allocate port->rx_fifo buffer in probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     gregkh@linuxfoundation.org, mgautam@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        akashast@codeaurora.org, rojay@codeaurora.org,
        msavaliy@qti.qualcomm.com
To:     skakit@codeaurora.org
Date:   Wed, 04 Mar 2020 09:48:08 -0800
Message-ID: <158334408852.7173.11568704753978099578@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting skakit@codeaurora.org (2020-03-04 05:34:20)
> As we mentioned in the V1 patch, we are passing drop=3D"true" to handle_r=
x=20
> function so it will read and discard whatever data present in RX FIFO,=20
> it won't send to upper layers.
> static int handle_rx_uart(struct uart_port *uport, u32 bytes, bool drop)
> {
>            ....
>        ioread32_rep(uport->membase + SE_GENI_RX_FIFOn, port->rx_fifo,=20
> words);
>          if (drop)
>                  return 0;
>            ....
> }
> In general uart_startup() is called before set_termios() ,but as per the =

> crash logs shared, it seems RX engine is active(which can only happen=20
> from set_termios) before startup() is called.So, if we allocate=20
> port->rx_fifo in probe we can overcome this crash.

Ok. Thanks for clarifying. Can you please mention in the commit text
that the fifo contents are read into rx_fifo but then dropped?
