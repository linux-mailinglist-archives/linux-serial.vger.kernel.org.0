Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DD459468
	for <lists+linux-serial@lfdr.de>; Fri, 28 Jun 2019 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfF1GwB (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Fri, 28 Jun 2019 02:52:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48218 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfF1GwB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Jun 2019 02:52:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6maur056652;
        Fri, 28 Jun 2019 06:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=FZoffX+D5xQsMUvbm3RMFTqFm9cTJgelJ/aG6LSGi8s=;
 b=qKOE6oZqGcoi54n1G+UdN9TeES41sNzR4ZfdmvYgWAPWQnixbnG8dFktmhj+tyXPKieP
 SXKBi3LDiUxqsIxa9GyYOAq732Bxhxxv0MBiJqjOYJZOT/LYmex+RvBv5LodtGZNiMCt
 ZV8OXXM/dHOAHazdwix9S7GWnSKAYnMDzRWSW2kjLr/TOmua1aodV2L0B/JPb161xOM+
 IB5vxt7NCT/WDEu34fHIiJDpTCVnwqBlgfu1D00xhw5s4Ixg+y4yd3w5pZllW5h7cCGz
 7oqUly8675GM2UJU3doWP88NpV0z1++gW/j2uxcDy3QZvya0x6hS41SW/zSTzfL2F4b+ /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2t9c9q3xfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:51:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S6op6r023564;
        Fri, 28 Jun 2019 06:51:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6vr234-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 06:51:57 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5S6pufd003971;
        Fri, 28 Jun 2019 06:51:57 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Jun 2019 23:51:56 -0700
Date:   Fri, 28 Jun 2019 09:51:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     yegorslists@googlemail.com
Cc:     linux-serial@vger.kernel.org
Subject: [bug report] tty/serial/8250: use mctrl_gpio helpers
Message-ID: <20190628065151.GA3159@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=855
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280077
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=899 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280077
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Yegor Yefremov,

This is a semi-automatic email about new static checker warnings.

The patch 4a96895f74c9: "tty/serial/8250: use mctrl_gpio helpers" 
from Jun 20, 2019, leads to the following Smatch complaint:

    drivers/tty/serial/8250/8250_core.c:1026 serial8250_register_8250_port()
    error: we previously assumed 'uart->port.dev' could be null (see line 988)

drivers/tty/serial/8250/8250_core.c
   987	
   988			if (uart->port.dev)
                            ^^^^^^^^^^^^^^
There is an existing check for NULL here.

   989				uart_remove_one_port(&serial8250_reg, &uart->port);
   990	
   991			uart->port.iobase       = up->port.iobase;
   992			uart->port.membase      = up->port.membase;
   993			uart->port.irq          = up->port.irq;
   994			uart->port.irqflags     = up->port.irqflags;
   995			uart->port.uartclk      = up->port.uartclk;
   996			uart->port.fifosize     = up->port.fifosize;
   997			uart->port.regshift     = up->port.regshift;
   998			uart->port.iotype       = up->port.iotype;
   999			uart->port.flags        = up->port.flags | UPF_BOOT_AUTOCONF;
  1000			uart->bugs		= up->bugs;
  1001			uart->port.mapbase      = up->port.mapbase;
  1002			uart->port.mapsize      = up->port.mapsize;
  1003			uart->port.private_data = up->port.private_data;
  1004			uart->tx_loadsz		= up->tx_loadsz;
  1005			uart->capabilities	= up->capabilities;
  1006			uart->port.throttle	= up->port.throttle;
  1007			uart->port.unthrottle	= up->port.unthrottle;
  1008			uart->port.rs485_config	= up->port.rs485_config;
  1009			uart->port.rs485	= up->port.rs485;
  1010			uart->dma		= up->dma;
  1011	
  1012			/* Take tx_loadsz from fifosize if it wasn't set separately */
  1013			if (uart->port.fifosize && !uart->tx_loadsz)
  1014				uart->tx_loadsz = uart->port.fifosize;
  1015	
  1016			if (up->port.dev)
  1017				uart->port.dev = up->port.dev;
  1018	
  1019			if (up->port.flags & UPF_FIXED_TYPE)
  1020				uart->port.type = up->port.type;
  1021	
  1022			/*
  1023			 * Only call mctrl_gpio_init(), if the device has no ACPI
  1024			 * companion device
  1025			 */
  1026			if (!has_acpi_companion(uart->port.dev)) {
                                                ^^^^^^^^^^^^^^
This new code doesn't checked NULL.

  1027				gpios = mctrl_gpio_init(&uart->port, 0);
  1028				if (IS_ERR(gpios)) {

regards,
dan carpenter
