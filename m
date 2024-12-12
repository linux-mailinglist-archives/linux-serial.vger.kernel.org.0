Return-Path: <linux-serial+bounces-7216-lists+linux-serial=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-serial@lfdr.de
Delivered-To: lists+linux-serial@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D219EEED8
	for <lists+linux-serial@lfdr.de>; Thu, 12 Dec 2024 17:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA5D189241F
	for <lists+linux-serial@lfdr.de>; Thu, 12 Dec 2024 15:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E66221D9C;
	Thu, 12 Dec 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GhBa2UBz"
X-Original-To: linux-serial@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15162185A0
	for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018998; cv=none; b=uHkPzXxo5mAMYu9KYl7m/G3MZO9I/OlHmYaAX3li6MSHyemooxlpQNbcJMFfym2nTH5qn3U8owQdTu5Obkw3KC/QmOAn1V1iemL/h2emY2aGB4fF5Odv++KkYG9xhTvSZ5tHhYEw2BvYprtc6pemKMIY33Hh0bwpgbNCw9e4+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018998; c=relaxed/simple;
	bh=3C4Yt5oeNRaxZqqS6cTEgAB9qT5fjNpBMGuaoHcL2gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAkwYuCQVeH1X9FD2ZpPhU5b2hpVoAaQoRPNH97eXdjLrFlocaoSEcQIzlvWXIJ19uHowU0Br9HRTVaQ+b1nYZAr+1LXAPDepnJUwElcMJhqUS/6p3Y431E4U8SrmAqYyjzEhLagTfSDmf2+KHHFwJ0SBZx7O6osQBuTvH+WYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GhBa2UBz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7okMm015261
	for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n3nqq3ds2PAwM46hFlxa1nrVPoI1aem45H25wLz0YZc=; b=GhBa2UBzDWDC9qNH
	PyDoEL6SJBJmonT+danyYZyzmWIv2g9+Oo/nj1/YYmW+uI7BYqeFfTRuWP7DFLNu
	1EeUurdeptMgCP4rArd/ZC9NK1R3thQS2F7WMjA/H4bYAw2641wGvHo8cydmoozp
	nVd/x4kOVwncwO+7CMBvy01BGo41AegqEcvXR4eYTusFPCxILVOaHW1IkEVdsJOi
	lTyYV63/7AWiovZ1aKIuD5AxSIOwyYPklN24lKrjuBmx8ZG4j79g6vwbaXW1Imox
	jHv17FXzLoE+0bSt3YcyH9GiENQmlsZRsXdPWXsbXl/BSztn82I0IcZs+Nxm7h+2
	QrcEDw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f7dpmsf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 15:56:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6dadb08366eso1685736d6.0
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2024 07:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734018995; x=1734623795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3nqq3ds2PAwM46hFlxa1nrVPoI1aem45H25wLz0YZc=;
        b=kh9tWAFs0F5m82a0jREj+Tz7SgY/uJRc/H5mV/ckigF84hMGJIErQjz6XCZYOWQvX1
         C1QURcuW2KRXCEWEyn1wgkCy+7WX3A3IpRJUP1Gc0lHekuKL6vq1mjXPvh9KhPj1Q9kF
         nb9mhogLYPcGZH93wnfXvrhxNfzFPV3K9gIzKDdRuZYeUEJqH8T3nO3ubMxZ7QIyGjZA
         JZzkQBo8pCVMQch9Y7k+3a6RNPrCKnjQdh1PygyWUaeRoMpNXuv9zqtoboEnCRxnWsvp
         r1Cn8l6Sb6950nqZyH8LF28ZFORjDh3GtbAsw3cJqYHiwoMFzgiqKhKeRGlObR7cY7I1
         Ygvw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ylG3UoTPzjrbRpTSSu+YjTz9wx0aPwaTD6Sq4q2mJbMi4oxNga7xGWlbAPnytcbqolEswNfwv7FB/J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2nI5UMtcgniJ+GqJ4k6WpBE9I6q5691e8Mm1TUgoK/471bxGU
	ES6NIanuMVbJBiOimi04W1A01kober7zEDffqbFQlZbmj0MLdjgoYR4HlipQ4iODI4i1baJqi0e
	hvLVxfP9ToWiZ7+UMmotET3tSfX1yslBqwlmnOTdcOZJepdovj1ypSIKes3EcDB0=
X-Gm-Gg: ASbGncuIcyGUJzOUoDCGDDjVKKUMYBl0Ioj8carKQzjPNl0xX5FLV5j3tbbY1J9DNt0
	5+7Lngx3+AVVX27I2uRVBZPacJK9t481EwS0zeRYuv/dNnWZatQ78HU5ZAfK6cmes48XWufh1I1
	f5ICZm36cmZe+F+NiD0q3/kW40+JREJyQtsHdgWjW4YxV8cek/8LP2TMUzNvyYbh0/fOgOaZwYk
	jTkLFVzabL5JaTMnG8BJ7lLO/giFmSnIVxN36PBCtp89tmQWuZY7iD/PohEMYWttkkBWPPSHlwx
	Jz9lZT2ahH4zitZxbEMitWyrVvFQjRZH/GSZNw==
X-Received: by 2002:a05:622a:199a:b0:467:5462:4a18 with SMTP id d75a77b69052e-467a13dbb86mr5797531cf.0.1734018994474;
        Thu, 12 Dec 2024 07:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrTTXRfbuepculS9NtXEOABh5da5aY3tMlxBBBwXa+/U6qTkKw/SXlHeil5FX0OuqtidmsCw==
X-Received: by 2002:a05:622a:199a:b0:467:5462:4a18 with SMTP id d75a77b69052e-467a13dbb86mr5797071cf.0.1734018993424;
        Thu, 12 Dec 2024 07:56:33 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683f9a8fbsm626885266b.37.2024.12.12.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 07:56:32 -0800 (PST)
Message-ID: <8ad1db59-9326-461a-ba8e-52891922eb3b@oss.qualcomm.com>
Date: Thu, 12 Dec 2024 16:56:30 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add support to load QUP SE firmware from
To: neil.armstrong@linaro.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        Viken Dadhaniya
 <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
        andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: =quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <9d5e5b8b-aeaf-4ec8-b34a-8edeaec20037@oss.qualcomm.com>
 <42b1c187-e924-4690-8338-4c694f3e16d9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42b1c187-e924-4690-8338-4c694f3e16d9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dpKSjyy0OP96WLM6dLZU_hS8sDqiMJ2-
X-Proofpoint-ORIG-GUID: dpKSjyy0OP96WLM6dLZU_hS8sDqiMJ2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120115

On 9.12.2024 3:45 PM, neil.armstrong@linaro.org wrote:
> On 05/12/2024 16:59, Konrad Dybcio wrote:
>> On 4.12.2024 4:03 PM, Viken Dadhaniya wrote:
>>> In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
>>> hardware has traditionally been managed by TrustZone (TZ). This setup
>>> handled Serial Engines(SE) assignments and access control permissions,
>>> ensuring a high level of security but limiting flexibility and
>>> accessibility.
>>>   This limitation poses a significant challenge for developers who need more
>>> flexibility to enable any protocol on any of the SEs within the QUP
>>> hardware.
>>>   To address this, we are introducing a change that opens the firmware
>>> loading mechanism to the Linux environment. This enhancement increases
>>> flexibility and allows for more streamlined and efficient management. We
>>> can now handle SE assignments and access control permissions directly
>>> within Linux, eliminating the dependency on TZ.
>>>   We propose an alternative method for firmware loading and SE
>>> ownership/transfer mode configuration based on device tree configuration.
>>> This method does not rely on other execution environments, making it
>>> accessible to all developers.
>>>   For SEs used prior to the kernel, their firmware will be loaded by the
>>> respective image drivers (e.g., Debug UART, Secure or trusted SE).
>>> Additionally, the GSI firmware, which is common to all SEs per QUPV3 core,
>>> will not be loaded by Linux driver but TZ only. At the kernel level, only
>>> the SE protocol driver should load the respective protocol firmware.
>>
>> I think this is a great opportunity to rethink the SE node in general.
>>
>> Currently, for each supported protocol, we create a new node that
>> differs in (possibly) interconnects and pinctrl states. These are really
>> defined per-SE however and we can programmatically determine which ones
>> are relevant.
>>
>> With the growing number of protocols supported, we would have to add
>> 20+ nodes in some cases for each one of them. I think a good one would
>> look like:
>>
>> geni_se10: serial-engine@abcdef {
>>     compatible = "qcom,geni-se";
>>
>>     reg
>>     clocks
>>     power-domains
>>     interconnects
>>     ...
>>
>>     status
>>
>>     geni_se10_i2c: i2c {
>>         // i2c-controller.yaml
>>     };
>>
>>     geni_se10_spi: spi {
>>         // spi-controller.yaml
>>     };
>>
>>     ...
>> }
>>
>> Or maybe even get rid of the subnodes and restrict that to a single
>> se-protocol = <SE_PROTOCOL_xyz> property, if the bindings folks agree.
>>
>> We could extend the DMA APIs to dynamically determine the protocol
>> ID and get rid of hardcoding it.
>>
>> And then we could spawn an instance of the spi, i2c, etc. driver from
>> the GENI SE driver.
> 
> How/where would you add the peripheral subnodes ? A Serial Engine can only be a
> single type on a board, but I agree we could have a "generic" serial engine node
> that would be differenciated in the board DT with the protocol, and use the bindings
> yaml checked to properly check the subnodes/properties depending on the protocol
> property.
> 
> But we would still need all the serial nodes in the SoC DT.

Correct, but NUM_PROTOCOLS times less. NUM_PROTOCOLS is 3 upstream as
of right now, but it's much higher in general (which will trickle
upstream one day or another).

> 
> This may make the software support harder, meaning we would either need to
> have the same compatible probed in sequence from the i2c/spi/uart driver until
> one matches the protocol, or have the qup driver spawn an auxiliary device.

No, just read back the protocol id from hardware (if the SE is running), or
from some DT property (if we need to load the FW ourselves).

Then, based on that, we can call

platform_device_register_data(dev, "geni_i2c", ...) 

(or similar)

> Honestly, not sure it would be much simpler...

Not sure if I'm happy to maintain NUM_QUPs * NUM_SEs * NUM_PROTOCOLS DT nodes,
per each platform separately..

Konrad

