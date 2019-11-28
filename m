Return-Path: <linux-serial-owner@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B6210C269
	for <lists+linux-serial@lfdr.de>; Thu, 28 Nov 2019 03:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfK1Cdi (ORCPT <rfc822;lists+linux-serial@lfdr.de>);
        Wed, 27 Nov 2019 21:33:38 -0500
Received: from sonic311-15.consmr.mail.bf2.yahoo.com ([74.6.131.125]:45283
        "EHLO sonic311-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727297AbfK1Cdi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Nov 2019 21:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574908416; bh=DOqWrmWu+W/KYtKDjlRQpFhjO+zjISRSE9Z3sCAfAt0=; h=Date:From:Reply-To:Subject:From:Subject; b=SYcwNOFiUwn+j9DB5zrXDubeerQAoOTwXSCklZCXjR/MrKp+0dBIT1RajAbzz4BBWXda5oq1SP6G2UW1APsnRRU1h9tbfdPAE79Xq/mgwVx66GVhdegCZ0kRDqY60LsNAw3mbldcONCmS0K8dvD8FUOjkcChWyswuglJDX2fkTnDO3fyTVRxko3m0e3LMiFg77Nimojm/yLFzRYmIMc/VePCWuLjL+yYEouKJznvu84sBPfLUaV0DgzQIjCJJHIzSqqB3K3Y9RYo1hf7Tftr65GU2OFDRj6z5/PsZ0xByXcNWOh6Xi9osB1w55dnhC7mZd8dyCvOxPb+qo5d2rg96A==
X-YMail-OSG: qRpcQkYVM1lxCe10Iou49dFvCfm5zA8hYP6q_amzQMX1QcbgLsb3v3J1zrQLYK6
 lAfkrzk547IyAgQlrqGFZTtwB81ipxRYi9ZKYYuXQIDyxaTOng1mp1phPrM4MpKzF4y.d9Tr2qxv
 ZqL7Ilddv4MLqebNkXFYFTpPPD.dNaJQFeK1Ui1iEi8vQuKls3fHvdTjE_FsVrxI4qnyLFUjmrjv
 17NXTQXwXv2DZG3P4nZ9mKCa9gns0tkGYlJ4omMvBlT4Yc93Q3UkbwuhBpbm9z7PD_dQ0nT7IUda
 GXH7CiB63L1rBhVctIERpMSukK1VqaPaN7vY1f8Qz89VVyqWRpiIuNaUCVBlrVOJUKUfFaN_lkIY
 B66tuSoUW5i.HJs3z1lidWNFrZkMOXJLbby_MybyL6.lxCar_M9YNanCZYOafl6JD31obmjyknRl
 t8iGgeqLLxyV8BNPgK2RxWGfJpDVe2AVsY62TG3EA5SSbNSulg5C1EDM_uIf9MiQwwG9fVppFtn_
 rQK.9G.duNn.vioagbWO1UDV0al_0ca8QmDi30lDN729kWx2JSmWz4_.ZS63RqUdhCLLs2ZVt61Y
 CrWAmi5pbvfg7Q3y2hXJNahLFQPLXVAZZmLMy_rSzJDlBrxIY6CyRnFIwQk9btHopgY5PWqQaw.H
 BZKHxzu.DlvNhk3ombncDLb3sm2HbBYxa.nYn8kOwdvYUdombIaZ9mCnfXN.X2T.esuzQ7ZV4aii
 xavexKE7bkZoicQvv.4Y50KAxXvbXTAoSIfPQZQpbEizKbVmxXDsDzRJEuArWQ_lLQPqWAC.kBIc
 cDhqX742T13ZE0wV7RdZoqgclfNszkIcCzdWAIlJMaVZePthmgqbnWs9KAIRKw7tn9Kr_.M1_0cT
 Ls35RbqMfKbd8x4xsGbAMFl7KcLaQyy7ug2vMvB1EyDeR9cPpgNzluRhjT6ueMKlU6ebsOz.pswA
 863lJH.eHN2_tRBeGaxFUdGnwv26pDdMhn4GtmizLHfyKqddkzjtoTPzuzdT_BqmksTvKLqyipqH
 .ffiPEHeVpDLqUPyJjSapPYNg1YImkpIckgOfYdu58uLifhMjpjAscz.TNUFzt14TyK7xV8ZPvPQ
 HN4WwB0wIyRlWrmdOTNFkGpIxkXnsPSHJuonJSLbHyQLxshJuIDccBzY9YzolgP9icHYoUfQQvBW
 PYUnG9yvdxeyeJ7jIBZ2nVrofZlhUPq9sEp9vNp_hvc6gxsXZ7xV9DzmellmG98d930o.QXAuDF4
 FlpAbljrS1GQM2h_0.1UO.bLvCzcjq5qPamX9X6LApAouWGVKTovh1U.vyFouoM2juLyo3HTuqw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Nov 2019 02:33:36 +0000
Date:   Thu, 28 Nov 2019 02:33:33 +0000 (UTC)
From:   United Nations <iespd54440135@gmail.com>
Reply-To: united.nation-finance@yandex.com
Message-ID: <1251465704.4135354.1574908413337@mail.yahoo.com>
Subject: Congratulation,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



Attention!!! your E-mail was selected as a Lucky winner of =E2=82=AC1,700.0=
00.00 Euro Only. Under the Spanish Government. the European Union Throw Lot=
tery of the year 2019 and you won. That is why we contact you for you Claim=
. meanwhile your fund sum =E2=82=AC1,700.000.00 Euros will be Credit in ATM=
 Card and send to you the choice is yours. Congratulation!

Yours Faithfully.

Ant=C3=B3nio Manuel de Oliveira Guterres
UN Secretary General
