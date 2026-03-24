#ifndef SPINE_SPINE_EVENT_DATA_H
#define SPINE_SPINE_EVENT_DATA_H

#include "../base.h"
#include "types.h"
#include "arrays.h"

#ifdef __cplusplus
extern "C" {
#endif

SPINE_C_API spine_event_data spine_event_data_create(const char *name);

SPINE_C_API void spine_event_data_dispose(spine_event_data self);

/**
 * The name of the event, unique across all events in the skeleton.
 */
SPINE_C_API const char *spine_event_data_get_name(spine_event_data self);
SPINE_C_API int spine_event_data_get_int(spine_event_data self);
SPINE_C_API void spine_event_data_set_int(spine_event_data self, int inValue);
SPINE_C_API float spine_event_data_get_float(spine_event_data self);
SPINE_C_API void spine_event_data_set_float(spine_event_data self, float inValue);
SPINE_C_API const char *spine_event_data_get_string(spine_event_data self);
SPINE_C_API void spine_event_data_set_string(spine_event_data self, const char *inValue);
SPINE_C_API const char *spine_event_data_get_audio_path(spine_event_data self);
SPINE_C_API void spine_event_data_set_audio_path(spine_event_data self, const char *inValue);
SPINE_C_API float spine_event_data_get_volume(spine_event_data self);
SPINE_C_API void spine_event_data_set_volume(spine_event_data self, float inValue);
SPINE_C_API float spine_event_data_get_balance(spine_event_data self);
SPINE_C_API void spine_event_data_set_balance(spine_event_data self, float inValue);

#ifdef __cplusplus
}
#endif

#endif /* SPINE_SPINE_EVENT_DATA_H */
