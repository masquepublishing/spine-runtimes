
package com.esotericsoftware.spine;

/** A posed object that may be active or inactive. */
abstract public class PosedActive< //
	D extends PosedData<P>, //
	P extends Pose> //
	extends Posed<D, P> {

	boolean active;

	protected PosedActive (D data, P pose, P constrained) {
		super(data, pose, constrained);
		setupPose();
	}

	/** Returns false when this constraint won't be updated by
	 * {@link Skeleton#updateWorldTransform(com.esotericsoftware.spine.Physics)} because a skin is required and the
	 * {@link Skeleton#getSkin() active skin} does not contain this item. See {@link Skin#getBones()},
	 * {@link Skin#getConstraints()}, {@link PosedData#getSkinRequired()}, and {@link Skeleton#updateCache()}. */
	public boolean isActive () {
		return active;
	}
}
