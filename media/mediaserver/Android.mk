LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifeq ($(QCOM_LISTEN_FEATURE),true)
  LOCAL_CFLAGS += -DQCOM_LISTEN_FEATURE_ENABLE
endif

LOCAL_SRC_FILES:= \
	main_mediaserver.cpp 

LOCAL_SHARED_LIBRARIES := \
	libaudioflinger \
	libcameraservice \
	libmediaplayerservice \
	libutils \
	libbinder

# FIXME The duplicate audioflinger is temporary
LOCAL_C_INCLUDES := \
    frameworks/av/media/libmediaplayerservice \
    frameworks/av/services/audioflinger \
    frameworks/av/services/camera/libcameraservice \
    frameworks/native/services/audioflinger

LOCAL_MODULE:= mediaserver

ifeq ($(QCOM_LISTEN_FEATURE),true)
  LOCAL_SHARED_LIBRARIES += liblisten
  LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-listen
endif

include $(BUILD_EXECUTABLE)
