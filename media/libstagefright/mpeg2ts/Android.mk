#
# This file was modified by Dolby Laboratories, Inc. The portions of the
# code that are surrounded by "DOLBY..." are copyrighted and
# licensed separately, as follows:
#
#  (C) 2012 Dolby Laboratories, Inc.
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

LOCAL_SRC_FILES:=                 \
        AnotherPacketSource.cpp   \
        ATSParser.cpp             \
        ESQueue.cpp               \
        MPEG2PSExtractor.cpp      \
        MPEG2TSExtractor.cpp      \

LOCAL_C_INCLUDES:= \
	$(TOP)/frameworks/av/media/libstagefright \
	$(TOP)/frameworks/native/include/media/openmax

LOCAL_MODULE:= libstagefright_mpeg2ts

ifdef DOLBY_UDC
#ifdef DOLBY_UDC_STREAMING_HLS
  LOCAL_CFLAGS += -DDOLBY_UDC
  LOCAL_CFLAGS += -DDOLBY_UDC_STREAMING_HLS
  LOCAL_C_INCLUDES += $(TOP)/hardware/qcom/media/mm-core/inc
#endif
endif #DOLBY_UDC
ifeq ($(TARGET_ARCH),arm)
    LOCAL_CFLAGS += -Wno-psabi
endif

include $(BUILD_STATIC_LIBRARY)
