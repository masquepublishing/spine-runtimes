
package com.esotericsoftware.spine;

abstract public class PosedActive< //
	D extends PosedData<P>, //
	P extends Pose, //
	A extends P> //
	extends Posed<D, P, A> {

	boolean active;

	public PosedActive (D data, A pose, A constrained) {
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
