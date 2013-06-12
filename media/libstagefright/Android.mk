#
# This file was modified by Dolby Laboratories, Inc. The portions of the
# code that are surrounded by "DOLBY..." are copyrighted and
# licensed separately, as follows:
#
#  (C) 2012-2013 Dolby Laboratories, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(BOARD_USES_ALSA_AUDIO),true)
    ifeq ($(call is-chipset-in-board-platform,msm8960),true)
        LOCAL_CFLAGS += -DUSE_TUNNEL_MODE
        LOCAL_CFLAGS += -DTUNNEL_MODE_SUPPORTS_AMRWB
    endif
    ifeq ($(call is-chipset-in-board-platform,msm8974),true)
        LOCAL_CFLAGS += -DUSE_TUNNEL_MODE
    endif
    ifeq ($(call is-chipset-in-board-platform,msm8226),true)
        LOCAL_CFLAGS += -DUSE_TUNNEL_MODE
    endif
    ifeq ($(call is-chipset-in-board-platform,msm8610),true)
        LOCAL_CFLAGS += -DUSE_TUNNEL_MODE
        LOCAL_CFLAGS += -DNO_TUNNEL_MODE_FOR_MULTICHANNEL
    endif
endif

include frameworks/av/media/libstagefright/codecs/common/Config.mk

LOCAL_SRC_FILES:=                         \
        ACodec.cpp                        \
        AACExtractor.cpp                  \
        AACWriter.cpp                     \
        AMRExtractor.cpp                  \
        AMRWriter.cpp                     \
        AudioPlayer.cpp                   \
        AudioSource.cpp                   \
        AwesomePlayer.cpp                 \
        CameraSource.cpp                  \
        CameraSourceTimeLapse.cpp         \
        DataSource.cpp                    \
        DRMExtractor.cpp                  \
        ESDS.cpp                          \
        ExtendedWriter.cpp                \
        FileSource.cpp                    \
        FLACExtractor.cpp                 \
        FragmentedMP4Extractor.cpp        \
        HTTPBase.cpp                      \
        JPEGSource.cpp                    \
        LPAPlayerALSA.cpp                 \
        MP3Extractor.cpp                  \
        MPEG2TSWriter.cpp                 \
        MPEG4Extractor.cpp                \
        MPEG4Writer.cpp                   \
        MediaBuffer.cpp                   \
        MediaBufferGroup.cpp              \
        MediaCodec.cpp                    \
        MediaCodecList.cpp                \
        MediaDefs.cpp                     \
        QCMediaDefs.cpp                   \
        MediaExtractor.cpp                \
        MediaSource.cpp                   \
        MetaData.cpp                      \
        NuCachedSource2.cpp               \
        NuMediaExtractor.cpp              \
        OMXClient.cpp                     \
        OMXCodec.cpp                      \
        QCOMXCodec.cpp                    \
        OggExtractor.cpp                  \
        SampleIterator.cpp                \
        SampleTable.cpp                   \
        SkipCutBuffer.cpp                 \
        StagefrightMediaScanner.cpp       \
        StagefrightMetadataRetriever.cpp  \
        SurfaceMediaSource.cpp            \
        ThrottledSource.cpp               \
        TimeSource.cpp                    \
        TimedEventQueue.cpp               \
        TunnelPlayer.cpp                  \
        Utils.cpp                         \
        VBRISeeker.cpp                    \
        WAVExtractor.cpp                  \
        WAVEWriter.cpp                    \
        WVMExtractor.cpp                  \
        XINGSeeker.cpp                    \
        avc_utils.cpp                     \
        mp4/FragmentedMP4Parser.cpp       \
        mp4/TrackFragment.cpp             \
        ExtendedExtractor.cpp             \
        FMA2DPWriter.cpp                  \
        QCUtilityClass.cpp                \

LOCAL_C_INCLUDES:= \
        $(TOP)/frameworks/av/include/media/stagefright/timedtext \
        $(TOP)/frameworks/native/include/media/hardware \
        $(TOP)/frameworks/native/include/media/openmax \
        $(TOP)/external/flac/include \
        $(TOP)/external/tremolo \
        $(TOP)/external/openssl/include \
        $(TOP)/hardware/qcom/media/mm-core/inc

LOCAL_SHARED_LIBRARIES := \
        libbinder \
        libcamera_client \
        libcrypto \
        libcutils \
        libdl \
        libdrmframework \
        libexpat \
        libgui \
        libicui18n \
        libicuuc \
        liblog \
        libmedia \
        libmedia_native \
        libsonivox \
        libssl \
        libstagefright_omx \
        libstagefright_yuv \
        libsync \
        libui \
        libutils \
        libvorbisidec \
        libz \

LOCAL_STATIC_LIBRARIES := \
        libstagefright_color_conversion \
        libstagefright_mp3dec \
        libstagefright_aacenc \
        libstagefright_matroska \
        libstagefright_timedtext \
        libvpx \
        libstagefright_mpeg2ts \
        libstagefright_httplive \
        libstagefright_id3 \
        libFLAC \

LOCAL_SRC_FILES += \
        chromium_http_stub.cpp
LOCAL_CPPFLAGS += -DCHROMIUM_AVAILABLE=1

LOCAL_SHARED_LIBRARIES += libstlport
include external/stlport/libstlport.mk

LOCAL_SHARED_LIBRARIES += \
        libstagefright_enc_common \
        libstagefright_avc_common \
        libstagefright_foundation \
        libdl

LOCAL_CFLAGS += -Wno-multichar

ifdef DOLBY_UDC
  LOCAL_CFLAGS += -DDOLBY_UDC
endif #DOLBY_UDC
ifdef DOLBY_UDC_MULTICHANNEL
  LOCAL_CFLAGS += -DDOLBY_UDC_MULTICHANNEL
endif #DOLBY_UDC_MULTICHANNEL
LOCAL_MODULE:= libstagefright

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
