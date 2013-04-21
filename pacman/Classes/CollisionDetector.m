//
// Created by JohnPoison <truefiresnake@gmail.com> on 4/20/13.




#import "CollisionDetector.h"
#import "GLWMath.h"
#import "PhysicalBody.h"
#import "GLWTypes.h"

// Structure that stores the results of the PolygonCollision function
typedef struct PolygonCollisionResult {
    // Are the polygons going to intersect forward in time?
    bool WillIntersect;
    // Are the polygons currently intersecting?
    bool Intersect;
    // The translation to apply to the first polygon to push the polygons apart.
    CGPoint MinimumTranslationVector;
} PolygonCollisionResult;

@implementation CollisionDetector {

}

// Calculate the projection of a polygon on an axis
// and returns it as a [min, max] interval
//void ProjectPolygon(CGPoint axis, PhysicalBody* polygon,
//         float* min, float* max) {
//    // To project a point on an axis use the dot product
//    CGPoint p = CGPointMake(polygon.shape[0].vertex.x , polygon.shape[0].vertex.y);
//    float dot = dotProduct(axis, p);
//    *min = dot;
//    *max = dot;
//    for (int i = 0; i < polygon.shapeVerticesCount; i++) {
//        CGPoint p = CGPointMake(polygon.shape[i].vertex.x , polygon.shape[0].vertex.y);
//        dot = dotProduct(axis, p);
//        if (dot < *min) {
//            *min = dot;
//        } else {
//            if (dot > *max) {
//                *max = dot;
//            }
//        }
//    }
//}

// Calculate the distance between [minA, maxA] and [minB, maxB]
// The distance will be negative if the intervals overlap
float IntervalDistance(float minA, float maxA, float minB, float maxB) {
    if (minA < minB) {
        return minB - maxA;
    } else {
        return minA - maxB;
    }
}

// Check if polygon A is going to collide with polygon B.
// The last parameter is the *relative* velocity
// of the polygons (i.e. velocityA - velocityB)
//PolygonCollisionResult PolygonCollision(PhysicalBody* polygonA,
//PhysicalBody* polygonB, CGPoint velocity) {
//    PolygonCollisionResult result;
//    result.Intersect = true;
//    result.WillIntersect = true;
//
//    int edgeCountA = polygonA.Edges.Count;
//    int edgeCountB = polygonB.Edges.Count;
//    float minIntervalDistance = float.PositiveInfinity;
//    Vector translationAxis = new Vector();
//    Vector edge;
//
//    // Loop through all the edges of both polygons
//    for (int edgeIndex = 0; edgeIndex < edgeCountA + edgeCountB; edgeIndex++) {
//        if (edgeIndex < edgeCountA) {
//            edge = polygonA.Edges[edgeIndex];
//        } else {
//            edge = polygonB.Edges[edgeIndex - edgeCountA];
//        }
//
//        // ===== 1. Find if the polygons are currently intersecting =====
//
//        // Find the axis perpendicular to the current edge
//        Vector axis = new Vector(-edge.Y, edge.X);
//        axis.Normalize();
//
//        // Find the projection of the polygon on the current axis
//        float minA = 0; float minB = 0; float maxA = 0; float maxB = 0;
//        ProjectPolygon(axis, polygonA, ref minA, ref maxA);
//        ProjectPolygon(axis, polygonB, ref minB, ref maxB);
//
//        // Check if the polygon projections are currentlty intersecting
//        if (IntervalDistance(minA, maxA, minB, maxB) > 0)\
//            result.Intersect = false;
//
//        // ===== 2. Now find if the polygons *will* intersect =====
//
//        // Project the velocity on the current axis
//        float velocityProjection = axis.DotProduct(velocity);
//
//        // Get the projection of polygon A during the movement
//        if (velocityProjection < 0) {
//            minA += velocityProjection;
//        } else {
//            maxA += velocityProjection;
//        }
//
//        // Do the same test as above for the new projection
//        float intervalDistance = IntervalDistance(minA, maxA, minB, maxB);
//        if (intervalDistance > 0) result.WillIntersect = false;
//
//        // If the polygons are not intersecting and won't intersect, exit the loop
//        if (!result.Intersect && !result.WillIntersect) break;
//
//        // Check if the current interval distance is the minimum one. If so store
//        // the interval distance and the current distance.
//        // This will be used to calculate the minimum translation vector
//        intervalDistance = Math.Abs(intervalDistance);
//        if (intervalDistance < minIntervalDistance) {
//            minIntervalDistance = intervalDistance;
//            translationAxis = axis;
//
//            Vector d = polygonA.Center - polygonB.Center;
//            if (d.DotProduct(translationAxis) < 0)
//                translationAxis = -translationAxis;
//        }
//    }
//
//    // The minimum translation vector
//    // can be used to push the polygons appart.
//    if (result.WillIntersect)
//        result.MinimumTranslationVector =
//                translationAxis * minIntervalDistance;
//
//    return result;
//}

@end