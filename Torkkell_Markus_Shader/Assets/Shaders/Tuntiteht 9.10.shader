Shader "Custom/Tuntiteht 9.10"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        
        [KeywordEnum(Object, World, View)]
        _Space ("Space", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline" = "UniversalPipeline" "Queue"="Geometry"}
        
        Pass
        {
            Name "Tuntiteht1"
            
            HLSLPROGRAM
            
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            #pragma  vertex Vert
            #pragma fragment Frag

            #pragma shader_feature_local_position _COLORKEYWORD_RED _COLORKEYWORD_BLUE _COLORKEYWORD_GREEN
            #pragma  shader_feature_local_vertex _SPACE_OBJECT _SPACE_WORLD _SPACE_VIEW

            float4 Vert(float3 positionOS: POSITION) : SV_POSITION {
                float4 positionHCS;

                #if _SPACE_OBJECT
                positionHCS = TransformObjectToHClip(positionOS + float3(0,1,0));
                #elif _SPACE_WORLD
                const float3 positionWS = TransformObjectToWorld(positionOS) + float3(0,1,0);
                positionHCS = TransformWorldToHClip(positionWS);
                #elif _SPACE_VIEW
                const float3 positionVS = TransformWorldToView(TransformObjectToWorld(positionOS));
                positionHCS = TransformWViewToHClip(positionVS + float3(0,1,0));
                #endif
                
                return positionHCS;

            }


            
            struct Attributes
            {
                float3 positionOS : POSITION;
                float3 normalOS : NORMAL; //Tee jotain surface normaleilla
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float3 positionWS : TEXCOORD0;
            };
            

            
            CBUFFER_START(UnityPerMaterial)
            float4 _Color;
            CBUFFER_END
            

            half4 Frag(const Varyings input) : SV_TARGET
            {
                //return half4(input.positionWS, 1);
                return _Color * clamp(input.positionWS.x, 0, 1);
            }
            
            ENDHLSL
        }
    }
}
