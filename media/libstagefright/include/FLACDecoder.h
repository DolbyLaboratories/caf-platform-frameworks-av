/*Copyright (c) 2014 The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *     * Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *      with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *      contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef FLAC_DECODER
#define FLAC_DECODER
#include "FLACDec_API.h"
#include <media/stagefright/MediaSource.h>
#include <media/stagefright/foundation/ADebug.h>

#define FLAC_OUTPUT_BUFFER_SIZE 8192*2*4
#define FLAC_INSTANCE_SIZE 8192*8*4

namespace android {

struct MediaBufferGroup;

class FLACDecoder : public MediaSource {
public:
    void decoderInit(CFlacDecState* pFlacDecState, int* nRes);
    void setMetaData(CFlacDecState* pFlacDecState, FLACDec_ParserInfo* parserInfoToPass);
    int* decoderLib_Process(CFlacDecState* pFlacDecState, uint8* pInBitStream, uint32 nActualDataLen,
                            void *pOutSamples, uint32* uFlacOutputBufSize, uint32* usedBitstream,
                            uint32* ui32BlockSize, uint32* bytesInInternalBuffer);
    FLACDecoder(const sp<MediaSource> &source);
    ~FLACDecoder();
    void init();
    virtual status_t start(MetaData *params);
    virtual status_t stop();
    virtual sp<MetaData> getFormat();
    virtual status_t read(MediaBuffer **buffer, const ReadOptions *options);

private:
    sp<MediaSource> mSource;
    sp<MetaData> mMeta;
    MediaBuffer *mInputBuffer;
    int32_t mNumChannels;
    int32_t mSampleRate;
    bool mStarted;
    MediaBufferGroup *mBufferGroup;
    int64_t mNumFramesOutput;
    int64_t mAnchorTimeUs;

    CFlacDecState pFlacDecState;
    FLACDec_ParserInfo parserInfoToPass;

};

}  // namespace android

#endif //FLAC_DECODER
