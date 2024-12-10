Return-Path: <linux-serial+bounces-7167-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A639EA99C
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2024 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED60E2885CD
	for <lists+linux-serial@lfdr.de>; Tue, 10 Dec 2024 07:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7922F39D;
	Tue, 10 Dec 2024 07:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z4pQ1yCr"
X-Original-To: linux-serial@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBD22F390;
	Tue, 10 Dec 2024 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815734; cv=none; b=B0vujlizdByScJnC/4EqIEV7l8AV/dR4GyT2pK5w8rldbISGqdWIVeEzcX5dAXojGz7wmtS/IjPgGWQDHKFFA2zkkxYxrqk+KH6UwonYg7ftc72ruHPP/uTsG6XR9sleCykfyDIPWJmkSYtnEw13sTJRYwHnA6ZtxQvnFNTLG5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815734; c=relaxed/simple;
	bh=LQBUAeKV4zBlTROofCU8Rmb0/AzjCFUn9sm3rRbCHhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcztJt+R04rbJMFmObRDT8v3rTsxqwCqKe9NVWAEbU9Vk6CrxwekzkxP//mOKGdMoA+eVj2fFbwD0JQiaOtnMFJXWTkyUX8JOJNq/Jcw+U+M2Y2DdIF288eX0ThXdGoy9dDpk6FBdK3MuqXkC8sQBfw8/CyOxbYFLBl5OXVBZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z4pQ1yCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125FFC4CED6;
	Tue, 10 Dec 2024 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733815733;
	bh=LQBUAeKV4zBlTROofCU8Rmb0/AzjCFUn9sm3rRbCHhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z4pQ1yCrdMhFGVsxCpA+aSmN87s1twdusI9zZoMLPeG/OTk9qLhFO8Eb1njBIJgPj
	 hh9/9YDznD8nFb0VVWima7wkQLgDmXAupu0QPUNicy7oJkD/JiP97o7L75eXk34Scg
	 U8VdQcJrNGFMzEpEy/omS7JiNiwth1SNBSVq+7ME=
Date: Tue, 10 Dec 2024 08:28:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nerdopolis <bluescreen_avenger@verizon.net>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
Message-ID: <2024121006-womb-outgoing-a4b6@gregkh>
References: <20241129041549.778959-1-bluescreen_avenger@verizon.net>
 <2959951.SvYEEZNnvj@nerdopolis2>
 <2024120911-daylight-feminist-a1e1@gregkh>
 <2682057.tIAgqjz4sF@nerdopolis2>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2682057.tIAgqjz4sF@nerdopolis2>

On Mon, Dec 09, 2024 at 09:56:01PM -0500, nerdopolis wrote:
> On Monday, December 9, 2024 1:35:04 AM EST Greg Kroah-Hartman wrote:
> > On Sun, Dec 08, 2024 at 09:16:28PM -0500, n3rdopolis wrote:
> > > On Sunday, December 8, 2024 8:30:08 AM EST Greg Kroah-Hartman wrote:
> > > > On Sun, Dec 08, 2024 at 12:25:12AM -0500, nerdopolis wrote:
> > > > > On Saturday, December 7, 2024 1:50:50 AM EST Greg Kroah-Hartman wrote:
> > > > > > On Fri, Dec 06, 2024 at 12:36:21PM -0500, n3rdopolis wrote:
> > > > > > > On Wednesday, December 4, 2024 2:37:55 PM EST n3rdopolis wrote:
> > > > > > > > On Wednesday, December 4, 2024 1:06:50 PM EST Greg Kroah-Hartman wrote:
> > > > > > > > > On Wed, Dec 04, 2024 at 12:06:56PM -0500, n3rdopolis wrote:
> > > > > > > > > > On Wednesday, December 4, 2024 10:41:44 AM EST Greg Kroah-Hartman wrote:
> > > > > > > > > > > On Thu, Nov 28, 2024 at 11:15:48PM -0500, n3rdopolis wrote:
> > > > > > > > > > > > Add a config option CONFIG_NULL_TTY_CONSOLE that will have ttynull be
> > > > > > > > > > > > initialized by console_initcall() and selected as a possible console
> > > > > > > > > > > > device.
> > > > > > > > > > > > Signed-off-by: n3rdopolis <bluescreen_avenger@verizon.net>
> > > > > > > > > > > 
> > > > > > > > > > > Meta-comments, we need a blank line before the s-o-b line, AND we need a
> > > > > > > > > > > real name here, sorry.  I can't do anything with these (including
> > > > > > > > > > > reviewing them), until that happens.
> > > > > > > > > > > 
> > > > > > > > > > Oh, I thought that I didn't need a real name
> > > > > > > > > > 
> > > > > > > > > > I found a recent thread that seems like it suggests that I thought
> > > > > > > > > > https://lore.kernel.org/all/20241121165806.476008-40-alex.bennee@linaro.org/[1]
> > > > > > > > > > https://drewdevault.com/2023/10/31/On-real-names.html[2]
> > > > > > > > > > Or do I need to wait for that change to the guideline be merged?
> > > > > > > > > 
> > > > > > > > > That change has been merged a long time ago, but as far as I can tell,
> > > > > > > > > this signed-off-by you used here does not meet this category.
> > > > > > > > > 
> > > > > > > > Oh, what would it take to meet that category? I've been using this nick to
> > > > > > > > contribute to other projects, and it matches my GitHub name, and FreeDesktop
> > > > > > > > GitLab name
> > > > > > > > 
> > > > > > > What if I made the signed-off-by (and committer name) this email address? would
> > > > > > > that work?
> > > > > > 
> > > > > > Do you sign documents with your bank with an email address in the line
> > > > > > that says "name"?
> > > > > > 
> > > > > No, I guess not, the no pseudonym requirement was dropped, but if my nickname
> > > > > doesn't work If I really have to, can it just be my first name, instead of my
> > > > > full name if it comes down to it?
> > > > 
> > > > No.
> > > > 
> > > 
> > > Can I do first name, last initial? Or does it have to be a full name?
> > 
> > Honestly, based on this long discussion, I really don't think we can
> > take any contribution from you without having someone else verify that
> > the the name you use here is correct.  Please work with the kernel.org
> > ring-of-trust to get a valid signature added to it and then I'll be glad
> > to reconsider.
> > 
> > And note, I'm not singling you out at all, we have recently had to do
> > this for many new contributors.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Understood, and I am sorry, I am trying to go though kernel.org to see,
> do you mean asking helpdesk@kernel.org ? I tried reading the documentation, but
> maybe I did not look in the right place

https://korg.docs.kernel.org/pgpkeys.html should help out

