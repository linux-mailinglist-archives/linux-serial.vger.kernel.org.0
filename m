Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD03B973
	for <lists+linux-serial@lfdr.de>; Mon, 10 Jun 2019 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfFJQbG (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 10 Jun 2019 12:31:06 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53592 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfFJQbG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jun 2019 12:31:06 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5AGUvbH100097;
        Mon, 10 Jun 2019 11:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560184257;
        bh=xUT/WRo9il3THF/VkZiqkZ05OahCx8/SlIQ234Tg/AY=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=oYv/HFs5fBA3Mn5OZtIUMS4q+wDN8vVRJcCZpYl14MZbx0vXjkB1itBVaDks3dmiT
         Y4z4wCdQsp8XtFwVFlZhglahMxMOU8kyTZd3gC0q2hWssh9JnpRo5YykZyvY1F3xXk
         CB9yj+iC1t/N5R2M+uerzWszlLqmOgEXyJ1VejBA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5AGUvB9128185
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 11:30:57 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 11:30:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 11:30:56 -0500
Received: from [10.250.133.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5AGUsNC007310;
        Mon, 10 Jun 2019 11:30:55 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: serial: 8250: Potential loss of transmission error information in
 serial8250_handle_irq
To:     Oliver Barta <o.barta89@gmail.com>, <linux-serial@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <CALJK04N=v9DQKkdL2cwrRmObWTHMikkv2vhV-eqrt_-J4tpLAg@mail.gmail.com>
Message-ID: <50ed2a4a-641e-e305-25ab-5cd2bffe5775@ti.com>
Date:   Mon, 10 Jun 2019 22:00:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALJK04N=v9DQKkdL2cwrRmObWTHMikkv2vhV-eqrt_-J4tpLAg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 09/06/19 5:20 PM, Oliver Barta wrote:
> Hello,
> 
> there is a small issue in serial8250_handle_irq function.
> 
>     status = serial_port_in(port, UART_LSR);
> 
>     if (status & (UART_LSR_DR | UART_LSR_BI) &&
>         iir & UART_IIR_RDI) {
>         if (!up->dma || handle_rx_dma(up, iir))
>             status = serial8250_rx_chars(up, status);
>     }
> 
> The line status register is read unconditionally but the contained
> error flags are processed only if UART_IIR_RDI bit is set in iir
> variable which was updated by a read of the interrupt identification
> register which happened before the read of LSR. It is unlikely but
> under certain timing conditions (steps for testing below) it may
> happen that some error flags are set while the UART_IIR_RDI bit is
> cleared in iir variable. In this case the error information (e.g.
> framing error or parity error) obtained from LSR will be lost as the
> bits in the hardware register are cleared by the read.
> 

Hmm, I see a different behavior on 8250 OMAP UARTs. LSR status does not
clear/reset back, until associated character is read from UART_RX
register (TRM has this behavior documented). So unconditional read of
LSR register w/o processing received character seems ok for OMAP UART.

This seems to be different wrt Designware UART.

> 
> This problem was introduced by commit
> 
> 2e9fe539108320820016f78ca7704a7342788380 serial: 8250: Don't service
> RX FIFO if interrupts are disabled
> 
> I see two possible solutions, either reverting this change or saving
> the error flags with
> 
> up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
> 
> in case they are not processed right away as done at several other
> places. I would vote for reverting it but I would like to hear a
> second opinion first.
> 
> 
> The commit message explains that the original change was required
> because some OMAP UART driver disables UART RX FIFO interrupts as
> response to a throttling request and it needs to be ensured that UART
> RX FIFO processing is actually stopped if the corresponding interrupts
> are disabled. I'm not sure if this is the right way to handle a
> throttling request. Based on the documentation in Documentation/serial
> I would expect a throttling request to only trigger hardware flow
> control to inform the sender that it should stop sending data. It
> should be the responsibility of the sender to act accordingly.

8250 OMAP UART support automatic HW flow control, which means HW manages
RTS signal automatically depending of FIFO level. Flow control is
asserted as soon as pre defined RX FIFO threshold is reached and signal
is deasserted once driver drains RX FIFO.
I am not sure if there is a way to assert signal manually when auto flow
control is enabled. Need to explore this option.

> Stopping processing of the input FIFO seems problematic to me as this
> FIFO is typically small and will likely overflow if input processing
> is stopped immediately.
> 

Not really, idea is to stop servicing RX FIFO interrupt and allow RX
FIFO to fill up. Once, FIFO level reaches threshold (3/4 of FIFO in 8250
OMAP UART) flow control line is automatically asserted by UART HW due to
autoRTS.

Also, even though driver disables the interrupt in throttle callback, it
would still service currently pending interrupt which would drain FIFO
completely at least once and then wait for FIFO to fill up to 3/4 before
flow control is asserted. 8250 OMAP UART as 64 byte FIFO and seems to
handle this situation well w/o any HW FIFO overruns in my testing.

I understand that LSR register read as different effect on DesignWare
platforms. Will experiment bit more and come up with a more generic fix
to fix throttling problem within next couple of days.
Otherwise will send a revert for the offending patch.

Regards
Vignesh
> 
> Steps to trigger this issue:
> 1) Send a data packet which is larger than the TX FIFO.
> 2) Trigger an external function generator on the outgoing data packet
> which is programmed to send a character with a parity error with a
> specific delay relative to the outgoing packet so that the character
> is received while the UART_IIR_THRI interrupt is processed in order to
> reload the TX FIFO. In particular it needs to be received between the
> read of IIR and LSR. (During my testing I added a delay of several
> micro seconds between both read operations to increase the probability
> for this to happen.)
> 3) Check if parity error information was properly processed.
> 
> I was testing on an Intel SOC with integrated DesignWare 16550A
> compatible UART without DMA support.
> 
> Best regards,
> Oliver Barta
> 

-- 
Regards
Vignesh
