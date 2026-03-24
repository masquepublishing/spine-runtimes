#ifndef SPINE_SPINE_PHYSICS_CONSTRAINT_BASE_H
#define SPINE_SPINE_PHYSICS_CONSTRAINT_BASE_H

#include "../base.h"
#include "types.h"
#include "arrays.h"

#ifdef __cplusplus
extern "C" {
#endif

SPINE_C_API void spine_physics_constraint_base_dispose(spine_physics_constraint_base self);

SPINE_C_API spine_physics_constraint_data spine_physics_constraint_base_get_data(spine_physics_constraint_base self);
SPINE_C_API spine_physics_constraint_pose spine_physics_constraint_base_get_pose(spine_physics_constraint_base self);
SPINE_C_API spine_physics_constraint_pose spine_physics_constraint_base_get_applied_pose(spine_physics_constraint_base self);
SPINE_C_API void spine_physics_constraint_base_reset_constrained(spine_physics_constraint_base self);
SPINE_C_API void spine_physics_constraint_base_constrained(spine_physics_constraint_base self);
SPINE_C_API bool spine_physics_constraint_base_is_pose_equal_to_applied(spine_physics_constraint_base self);
/**
 * Returns false when this won't be updated by
 * Skeleton::updateWorldTransform(Physics) because a skin is required and the
 * active skin does not contain this item. See Skin::getBones(),
 * Skin::getConstraints(), PosedData::getSkinRequired(), and
 * Skeleton::updateCache().
 */
SPINE_C_API bool spine_physics_constraint_base_is_active(spine_physics_constraint_base self);
SPINE_C_API void spine_physics_constraint_base_set_active(spine_physics_constraint_base self, bool active);
SPINE_C_API spine_rtti spine_physics_constraint_base_get_rtti(spine_physics_constraint_base self);
SPINE_C_API void spine_physics_constraint_base_sort(spine_physics_constraint_base self, spine_skeleton skeleton);
SPINE_C_API bool spine_physics_constraint_base_is_source_active(spine_physics_constraint_base self);
/**
 * Inherited from Update
 */
SPINE_C_API void spine_physics_constraint_base_update(spine_physics_constraint_base self, spine_skeleton skeleton, spine_physics physics);
SPINE_C_API spine_rtti spine_physics_constraint_base_rtti(void);

#ifdef __cplusplus
}
#endif

#endif /* SPINE_SPINE_PHYSICS_CONSTRAINT_BASE_H */
