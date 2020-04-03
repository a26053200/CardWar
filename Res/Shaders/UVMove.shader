// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Game/Background"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
        _ScrollY("_ScrollY", float) = 1
        _ScrollX("_ScrollX", float) = 1
    }
    SubShader
    {
        Tags{"RenderType"="Opaque"}
        //Cull Back
        
        Pass
        {
            Tags{ "LightMode" = "ForwardBase"}
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            //要想有正确的衰减内置变量等，必须要有这句
            #pragma multi_compile_fwdbase
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            // #include "Lighting.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float4 _Color;
            float4 _LightColor0;
            
            float _ScrollX;
            float _ScrollY;
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                //float3 normal : NORMAL;
                float4 pos : SV_POSITION;
                //float3 lightDir : TEXCOORD1;
                //float3 workdPos : TEXCOORD2;
                //float3 viewDir : TEXCOORD3;
                SHADOW_COORDS(1)    //宏表示为定义一个float4的采样坐标，放到编号为1的寄存器中
                // LIGHTING_COORDS(2, 3)
            };
            
            
            
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex) + float2(_ScrollX, _ScrollY) * _Time.y;
                //o.normal = v.normal;
                //o.lightDir = ObjSpaceLightDir(v.vertex);
                //o.viewDir = ObjSpaceViewDir(v.vertex);
                // TRANSFER_VERTEX_TO_FRAGMENT(o);
                TRANSFER_SHADOW(o); 
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                //fixed lightAttenuation = LIGHT_ATTENUATION(i);
                fixed shadowAttenuation = SHADOW_ATTENUATION(i); //根据贴图与纹理坐标对纹理采样得到shadow值。
                //fixed3 lightColor = _LightColor0 * attenuation;
                fixed4 col = tex2D(_MainTex, frac(i.uv));
                return col * _Color * shadowAttenuation;
                //return fixed4(col.rgb * _Color.rgb * shadowAttenuation, 1);
            }
            ENDCG
        }
    }
    FallBack "Specular"
}
