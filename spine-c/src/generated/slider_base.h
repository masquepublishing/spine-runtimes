#ifndef SPINE_SPINE_SLIDER_BASE_H
#define SPINE_SPINE_SLIDER_BASE_H

#include "../base.h"
#include "types.h"
#include "arrays.h"

#ifdef __cplusplus
extern "C" {
#endif

SPINE_C_API void spine_slider_base_dispose(spine_slider_base self);

SPINE_C_API spine_slider_data spine_slider_base_get_data(spine_slider_base self);
SPINE_C_API spine_slider_pose spine_slider_base_get_pose(spine_slider_base self);
SPINE_C_API spine_slider_pose spine_slider_base_get_applied_pose(spine_slider_base self);
SPINE_C_API void spine_slider_base_reset_constrained(spine_slider_base self);
SPINE_C_API void spine_slider_base_constrained(spine_slider_base self);
SPINE_C_API bool spine_slider_base_is_pose_equal_to_applied(spine_slider_base self);
/**
 * Returns false when this won't be updated by
 * Skeleton::updateWorldTransform(Physics) because a skin is required and the
 * active skin does not contain this item. See Skin::getBones(),
 * Skin::getConstraints(), PosedData::getSkinRequired(), and
 * Skeleton::updateCache().
 */
SPINE_C_API bool spine_slider_base_is_active(spine_slider_base self);
SPINE_C_API void spine_slider_base_set_active(spine_slider_base self, bool active);
SPINE_C_API spine_rtti spine_slider_base_get_rtti(spine_slider_base self);
SPINE_C_API void spine_slider_base_sort(spine_slider_base self, spine_skeleton skeleton);
SPINE_C_API bool spine_slider_base_is_source_active(spine_slider_base self);
/**
 * Inherited from Update
 */
SPINE_C_API void spine_slider_base_update(spine_slider_base self, spine_skeleton skeleton, spine_physics physics);
SPINE_C_API spine_rtti spine_slider_base_rtti(void);

#ifdef __cplusplus
}
#endif

#endif /* SPINE_SPINE_SLIDER_BASE_H */
