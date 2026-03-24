
package com.esotericsoftware.spine;

/** The base class for an object with a number of poses:
 * <ul>
 * <li>{@link #getData()}: The setup pose.
 * <li>{@link #getPose()}: The unconstrained pose. Set by animations and application code.
 * <li>{@link #getAppliedPose()}: The constrained pose. The {@link #getPose()} with modifications by constraints.
 * </ul>
 */
abstract public class Posed< //
	D extends PosedData<P>, //
	P extends Pose, //
	A extends P> {

	final D data;
	final A pose;
	final A constrained;
	A applied;

	public Posed (D data, A pose, A constrained) {
		if (data == null) throw new IllegalArgumentException("data cannot be null.");
		this.data = data;
		this.pose = pose;
		this.constrained = constrained;
		applied = pose;
	}

	/** Sets the unconstrained pose to the setup pose. */
	public void setupPose () {
		pose.set(data.setup);
	}

	/** The setup pose data. May be shared with multiple instances. */
	public D getData () {
		return data;
	}

	/** The unconstrained pose for this object, set by animations and application code. */
	public P getPose () {
		return pose;
	}

	/** If no constraints modify this object, the applied pose is the same as the {@link #pose}. Otherwise it is a copy of the
	 * {@link #pose} modified by constraints. */
	public A getAppliedPose () {
		return applied;
	}

	/** Sets the applied pose to the unconstrained pose, for when no constraints will modify the pose. */
	void pose () { // Port: usePose
		applied = pose;
	}

	/** Sets the applied pose to the constrained pose, in anticipation of the applied pose being modified by constraints. */
	void constrained () { // Port: useConstrained
		applied = constrained;
	}

	/** Sets the constrained pose to the unconstrained pose, as a starting point for constraints to be applied. */
	void reset () { // Port: resetConstrained
		constrained.set(pose);
	}

	public String toString () {
		return data.name;
	}
}
