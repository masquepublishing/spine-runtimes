
package com.esotericsoftware.spine;

/** The base class for an object with a number of poses:
 * <ul>
 * <li>{@link #data}: The setup pose.
 * <li>{@link #pose}: The unconstrained pose. Set by animations and application code.
 * <li>{@link #getAppliedPose()}: The constrained pose. The {@link #pose} with modifications by constraints.
 * </ul>
 */
abstract public class Posed< //
	D extends PosedData<P>, //
	P extends Pose> {

	final D data;
	final P pose;
	final P constrained;
	P applied;

	protected Posed (D data, P pose, P constrained) {
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
	public P getAppliedPose () {
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
