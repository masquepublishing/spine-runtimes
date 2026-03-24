#ifndef SPINE_SPINE_SLIDER_H
#define SPINE_SPINE_SLIDER_H

#include "../base.h"
#include "types.h"
#include "arrays.h"

#ifdef __cplusplus
extern "C" {
#endif

SPINE_C_API spine_slider spine_slider_create(spine_slider_data data, spine_skeleton skeleton);

SPINE_C_API void spine_slider_dispose(spine_slider self);

SPINE_C_API spine_rtti spine_slider_get_rtti(spine_slider self);
SPINE_C_API spine_slider spine_slider_copy(spine_slider self, spine_skeleton skeleton);
SPINE_C_API void spine_slider_update(spine_slider self, spine_skeleton skeleton, spine_physics physics);
SPINE_C_API void spine_slider_sort(spine_slider self, spine_skeleton skeleton);
SPINE_C_API bool spine_slider_is_source_active(spine_slider self);
SPINE_C_API spine_bone spine_slider_get_bone(spine_slider self);
SPINE_C_API void spine_slider_set_bone(spine_slider self, spine_bone bone);
SPINE_C_API spine_slider_data spine_slider_get_data(spine_slider self);
SPINE_C_API spine_slider_pose spine_slider_get_pose(spine_slider self);
SPINE_C_API spine_slider_pose spine_slider_get_applied_pose(spine_slider self);
SPINE_C_API void spine_slider_reset_constrained(spine_slider self);
SPINE_C_API void spine_slider_constrained(spine_slider self);
SPINE_C_API bool spine_slider_is_pose_equal_to_applied(spine_slider self);
/**
 * Returns false when this won't be updated by
 * Skeleton::updateWorldTransform(Physics) because a skin is required and the
 * active skin does not contain this item. See Skin::getBones(),
 * Skin::getConstraints(), PosedData::getSkinRequired(), and
 * Skeleton::updateCache().
 */
SPINE_C_API bool spine_slider_is_active(spine_slider self);
SPINE_C_API void spine_slider_set_active(spine_slider self, bool active);
SPINE_C_API spine_rtti spine_slider_rtti(void);

#ifdef __cplusplus
}
#endif

#endif /* SPINE_SPINE_SLIDER_H */
