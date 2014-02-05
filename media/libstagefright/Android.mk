#
# This file was modified by Dolby Laboratories, Inc. The portions of the
# code that are surrounded by "DOLBY..." are copyrighted and
# licensed separately, as follows:
#
#  (C) 2012-2014 Dolby Laboratories, Inc.
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
        FileSource.cpp                    \
        FLACExtractor.cpp                 \
        HTTPBase.cpp                      \
        JPEGSource.cpp                    \
        MP3Extractor.cpp                  \
        MPEG2TSWriter.cpp                 \
        MPEG4Extractor.cpp                \
        MPEG4Writer.cpp                   \
        MediaAdapter.cpp                  \
        MediaBuffer.cpp                   \
        MediaBufferGroup.cpp              \
        MediaCodec.cpp                    \
        MediaCodecList.cpp                \
        MediaDefs.cpp                     \
        MediaExtractor.cpp                \
        MediaMuxer.cpp                    \
        MediaSource.cpp                   \
        MetaData.cpp                      \
        NuCachedSource2.cpp               \
        NuMediaExtractor.cpp              \
        OMXClient.cpp                     \
        OMXCodec.cpp                      \
        ExtendedCodec.cpp                 \
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
        ExtendedUtils.cpp                 \
        FMA2DPWriter.cpp                  \

LOCAL_C_INCLUDES:= \
        $(TOP)/frameworks/av/include/media/stagefright/timedtext \
        $(TOP)/frameworks/native/include/media/hardware \
        $(TOP)/frameworks/native/include/media/openmax \
        $(TOP)/frameworks/native/services/connectivitymanager \
        $(TOP)/external/flac/include \
        $(TOP)/external/tremolo \
        $(TOP)/external/openssl/include \

LOCAL_SHARED_LIBRARIES := \
        libbinder \
        libcamera_client \
        libconnectivitymanager \
        libcutils \
        libdl \
        libdrmframework \
        libexpat \
        libgui \
        libicui18n \
        libicuuc \
        liblog \
        libmedia \
        libsonivox \
        libssl \
        libstagefright_omx \
        libstagefright_yuv \
        libsync \
        libui \
        libutils \
        libvorbisidec \
        libz \
        libpowermanager

#QTI FLAC Decoder
ifeq ($(call is-vendor-board-platform,QCOM),true)
ifeq ($(strip $(BOARD_USES_QTI_FLAC_DECODER)),true)
LOCAL_SRC_FILES += FLACDecoder.cpp
LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio-noship/audio-flac
LOCAL_CFLAGS := -DQTI_FLAC_DECODER
endif
endif

LOCAL_STATIC_LIBRARIES := \
        libstagefright_color_conversion \
        libstagefright_aacenc \
        libstagefright_matroska \
        libstagefright_timedtext \
        libvpx \
        libwebm \
        libstagefright_mpeg2ts \
        libstagefright_id3 \
        libFLAC \
        libmedia_helper

ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS),true)
       LOCAL_CFLAGS     += -DENABLE_AV_ENHANCEMENTS
       LOCAL_C_INCLUDES += $(TOP)/hardware/qcom/media/mm-core/inc
       LOCAL_SRC_FILES  += ExtendedMediaDefs.cpp
endif #TARGET_ENABLE_AV_ENHANCEMENTS

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
  LOCAL_CFLAGS += -DDOLBY_UDC_OMX_BUFFER_FLUSH
endif #DOLBY_UDC
ifdef DOLBY_DAP
    ifdef DOLBY_DAP_OPENSLES
        LOCAL_CFLAGS += -DDOLBY_DAP_OPENSLES
    endif
endif #DOLBY_END
LOCAL_MODULE:= libstagefright

LOCAL_MODULE_TAGS := optional


ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS),true)
       LOCAL_CFLAGS += -DENABLE_AV_ENHANCEMENTS
       LOCAL_SRC_FILES  += ExtendedWriter.cpp
       LOCAL_C_INCLUDES += $(TOP)/hardware/qcom/media/mm-core/inc
       LOCAL_C_INCLUDES += $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include
       LOCAL_ADDITIONAL_DEPENDENCIES := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr
endif #TARGET_ENABLE_QC_AV_ENHANCEMENTS

include $(BUILD_SHARED_LIBRARY)

include $(call all-makefiles-under,$(LOCAL_PATH))
