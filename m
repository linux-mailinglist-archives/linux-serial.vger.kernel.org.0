Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9A7A42EF
	for <lists+linux-serial@lfdr.de>; Mon, 18 Sep 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjIRHiV (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Mon, 18 Sep 2023 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjIRHiE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Sep 2023 03:38:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE3172C
        for <linux-serial@vger.kernel.org>; Mon, 18 Sep 2023 00:34:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD04C433CB;
        Mon, 18 Sep 2023 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695022472;
        bh=y//pdCXR6GTFFIfCBdd1rId3XKKRia+qOF2fFbGyCak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUYPZuVX2bFnom9W+IDkz1xUAFn0tFiU2UIuV+Iusys4hWTs7NCl+r7qPzmuwYTmb
         Ws8UcbK0xzQTadzfqaXoO8pdPQ02GEz7qOjl9YwOQRtyLRF0bM9+Jey2K4PYYNZInW
         gQMW28C/FBpBv19ZuAldy5AcXqyxrg5r6pz6lRBk=
Date:   Mon, 18 Sep 2023 09:34:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Howell <matthew.howell@sealevel.com>
Cc:     jeff.baldwin@sealevel.com, james.olson@sealevel.com,
        ryan.wenglarz@sealevel.com, darren.beeson@sealevel.com,
        linux-serial@vger.kernel.org, andriy.shevchenko@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH V6 1/2] serial: exar: Revert "serial: exar: Add support
 for Sealevel 7xxxC serial cards"
Message-ID: <2023091847-wireless-snowdrop-5e0a@gregkh>
References: <b5c01f33-35fa-e974-8f55-9b19d3b9de18@sealevel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c01f33-35fa-e974-8f55-9b19d3b9de18@sealevel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Sep 14, 2023 at 04:50:32PM -0400, Matthew Howell wrote:
> From: Matthew Howell <matthew.howell@sealevel.com>
> 
> Hardware ID of Sealevel 7xxxC cards changed prior to release. This has 

trailing whitespace :(

> rendered 14ee78d5932a redundant.
> 
> Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
> 
> This reverts commit 14ee78d5932afeb710c8305196a676a715bfdea8.
> 
> Link: https://lore.kernel.org/all/a804d136-4865-f528-6434-68a7358d7606@sealevel.com/T/

No need for this :(

> Fixes: 14ee78d5932a ("Add support for Sealevel 7xxxC serial cards")

Shouldn't you also cc: stable?

thanks,

greg k-h
