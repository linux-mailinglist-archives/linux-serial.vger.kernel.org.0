Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F3A6032A9
	for <lists+linux-serial@lfdr.de>; Tue, 18 Oct 2022 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJRSnb (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Tue, 18 Oct 2022 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJRSmG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Oct 2022 14:42:06 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E298E461
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2022 11:42:05 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id p89so5869579uap.12
        for <linux-serial@vger.kernel.org>; Tue, 18 Oct 2022 11:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9G1TFmLPWxtTEROXa3EgKVxLt69MAzXIdwglwBoviU=;
        b=ebhgea+WYZgxfilLwCK8DwF9TxPIzdETOuPMYYmPD+3pwWKu1QERiKnxuqWBA7ENvL
         ktssYy4RQCjTG/sjtojGxQSCKyh544nDLd0ZwL2ua0JOLtrV7usGQcOL2Au1bak+XHyT
         r3zrXROjgfuyxxsXyDyYScd8KPJCpT7vUbMiitQ8ae1//dNPwmCG40l7JBucy+UUHBRD
         bB/S+lu/1PJNg7YwToRWY/kEAVlao4/T1owyu3eLEd/sWg4uhQPYDRSbomC/eGq0i8RZ
         PpOl9t+AVpPtVUOYZG3Ts/62agoWbn5ZY1AuMGH7bSl7zx/1eZ8or5wwavAWmCRlGceB
         YHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9G1TFmLPWxtTEROXa3EgKVxLt69MAzXIdwglwBoviU=;
        b=Jp1YcxDuVDkpEesGBBeKOVQ5sBiMAhoOdsU25NFDVZetd0Ae9E2Y1jH+4G2l6hCuFT
         T9NU56MPevua7dssYWt2xMy8oiI/SAZZJ78OtnRCIaDIxWwY34Mg/o7oK9FhGNacUqhZ
         h3U+d5TF9h3ItUU7zetImUVSvyQRVoycMBU79NmGpTJOEdLUlHH+ZbH+BILuWb3WeqNM
         nFO0eHxRfcGYVl8BfC+4hxgCcWQZGgwDEiKVI+7MNEntrIIhl9FIdt8FRA40Q4p9SA7N
         GRG6CgV2dpM0gC2NSys9j7TUf8fPPMqmgLJfgKSROilVi4IY87jiWjgISBz/DXoibwgB
         uedA==
X-Gm-Message-State: ACrzQf32z7KcWXta4deVkKvqq19Sijd6Ul6tZRXY2FijA1rypnf1L9w/
        nxuUV7Yf70d+AofQ4cJHMotC844KvqeEc5kIYV0=
X-Google-Smtp-Source: AMsMyM6Po9fUIBmyLVjh+jrKbqWaEyipV+x1nF2jctjDU9bBMwsnBGszruXWNQko5k/O3UqwPmMA7m/9AVQFNgXUPKU=
X-Received: by 2002:ab0:3855:0:b0:3d8:6475:49f8 with SMTP id
 h21-20020ab03855000000b003d8647549f8mr2354800uaw.78.1666118524144; Tue, 18
 Oct 2022 11:42:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:2209:b0:31a:c0a0:2913 with HTTP; Tue, 18 Oct 2022
 11:42:03 -0700 (PDT)
Reply-To: iilluminatiinitiationcenter0@gmail.com
From:   Garry Lee <janenakibuka0@gmail.com>
Date:   Tue, 18 Oct 2022 21:42:03 +0300
Message-ID: <CAN6xanNXCMAqLxWF1K3iqG70NnhM4nLqcJL6B_9n2nuaEmmL_w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        UNDISC_FREEM,UPPERCASE_75_100 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:935 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [iilluminatiinitiationcenter0[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [janenakibuka0[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [janenakibuka0[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 UPPERCASE_75_100 message body is 75-100% uppercase
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

-- 
DO YOU WANT TO BE RICH AND FAMOUS? JOIN THE GREAT ILLUMINATI ORDER OF
RICHES, POWER/FAME  NOW AND ACHIEVE ALL YOUR DREAMS? IF YES EMAIL US :
MAIL: illuminatiinitiationcenter0@gmail.com

YOUR FULL NAME:
PHONE NUMBER :
COUNTRY :
GENDER:
