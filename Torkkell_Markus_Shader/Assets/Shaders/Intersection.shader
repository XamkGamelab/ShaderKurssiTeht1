Shader "Custom/Intersection"
{
    Properties
    {
        _Color("Color", Color) = (1, 1, 1, 1)
        _IntersectionColor("Intersection Color", Color) = (0, 0, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent" "RenderPipeline"="UniversalPipeline" }
        
        Pass
        {
            Name "IntersectionUnlit"
            Tags { "LightMode"="SRPDefaultUnlit" }
            
            Cull Back
            Blend One Zero
            ZTest LEqual
            ZWrite On
            
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
            };

            struct Varyings
            {
                float3 positionWS : TEXCOORD1;
                float4 positionHCS : SV_POSITION;
            };

            Varyings vert (Attributes input)
            {
                Varyings output;
                output.positionHCS = TransformObjectToHClip(input.positionOS.xyz);
                output.positionWS = TransformObjectToWorld(input.positionOS.xyz);
                return output;
            }

             half4 frag(const Varyings input) : SV_TARGET
            {
                const float3 screenSpaceUV = GetNormalizedScreenSpaceUV(positionHCS);
                SampleSceneDepth(screenUV) = LinearEyeDepth(SceneDepth, _ZBufferParams);
                SampleSceneDepth(screenUV) =  LinearEyeDepth(positionWS, UNITY_MATRIX_V);
                pow(1 - saturate(depthTexture - depthObject), 15);
                lerp(colObject, colIntersection, lerpValue);
                
            }

            ENDHLSL
        }
    }
}